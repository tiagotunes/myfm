import * as bcrypt from 'bcrypt';
import {
  ConflictException,
  Injectable,
  InternalServerErrorException,
  UnauthorizedException,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { UserService } from '@/users/user.service';
import { User } from '@/users/user.entity';
import { ErrorCode } from '@/common/constants/error-codes';
import { SignInDto } from '@/auth/dtos/sing-in.dto';
import { SignUpDto } from '@/auth/dtos/sign-up.dto';

@Injectable()
export class AuthService {
  constructor(
    private readonly usersService: UserService,
    private readonly jwtService: JwtService,
    private readonly configService: ConfigService,
  ) {}

  async generateTokens(
    user: User,
  ): Promise<{ access_token: string; refresh_token: string; role: string }> {
    const accessPayload = { sub: user.id, role: user.role };
    const refreshPayload = { sub: user.id, role: user.role };

    const [accessToken, refreshToken] = await Promise.all([
      this.jwtService.signAsync(accessPayload, {
        secret: this.configService.getOrThrow('JWT_ACCESS_TOKEN_SECRET'),
        expiresIn: this.configService.getOrThrow('JWT_ACCESS_TOKEN_EXPIRY'),
      }),
      this.jwtService.signAsync(refreshPayload, {
        secret: this.configService.getOrThrow('JWT_REFRESH_TOKEN_SECRET'),
        expiresIn: this.configService.getOrThrow('JWT_REFRESH_TOKEN_EXPIRY'),
      }),
    ]);

    const refreshTokenHash = await bcrypt.hash(refreshToken, 10);

    await this.usersService.updateRefreshToken(user.id, refreshTokenHash);

    return {
      access_token: accessToken,
      refresh_token: refreshToken,
      role: user.role,
    };
  }

  async refreshToken(user: {
    id: string;
  }): Promise<{ access_token: string; refresh_token: string; role: string }> {
    const dbUser = await this.usersService.findById(user.id);
    if (!dbUser || !dbUser.isActive) {
      throw new UnauthorizedException({
        message: ErrorCode.AUTH_ACCOUNT_DISABLED,
      });
    }
    return this.generateTokens(dbUser);
  }

  async signIn(
    body: SignInDto,
  ): Promise<{ access_token: string; refresh_token: string }> {
    const user = await this.usersService.findByEmailForAuthentication(
      body.email,
    );

    const passwordHash = user?.password ?? '$2b$10$invalidhashstring';
    const passwordValid = await bcrypt.compare(body.password, passwordHash);

    if (!user || !passwordValid) {
      throw new UnauthorizedException({
        message: ErrorCode.AUTH_INVALID_CREDENTIALS,
      });
    }

    if (!user.isActive) {
      throw new UnauthorizedException({
        message: ErrorCode.AUTH_ACCOUNT_DISABLED,
      });
    }

    await this.usersService.updateLastLogin(user.id);
    user.lastLoginAt = new Date();

    return this.generateTokens(user);
  }

  async signOut(user: { id: string }): Promise<void> {
    await this.usersService.updateRefreshToken(user.id, null);
  }

  async signUp(body: SignUpDto): Promise<{
    access_token: string;
    refresh_token: string;
    role: string;
  }> {
    const user = await this.usersService.findByEmail(body.email);

    if (user) {
      throw new ConflictException({
        message: ErrorCode.SIGN_USER_ALREADY_EXISTS,
      });
    }

    const passwordHash = await bcrypt.hash(body.password, 10);

    const newUser = await this.usersService.create(
      new User({
        email: body.email,
        password: passwordHash,
        name: body.name,
      }),
    );

    if (!newUser) {
      throw new InternalServerErrorException({
        message: ErrorCode.AUTH_CREATE_USER_ERROR,
      });
    }

    return this.generateTokens(newUser);
  }
}
