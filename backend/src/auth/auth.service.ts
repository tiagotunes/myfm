import {
  ConflictException,
  Injectable,
  InternalServerErrorException,
  UnauthorizedException,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as bcrypt from 'bcrypt';
import { UsersService } from 'src/users/users.service';
import { User } from 'src/users/entities/user.entity';
import { ErrorCode } from 'src/common/constants/error-codes';
import { JwtService } from '@nestjs/jwt';
import { SignInDto } from './dtos/sing-in.dto';
import { SignUpDto } from './dtos/sign-up.dto';

@Injectable()
export class AuthService {
  constructor(
    private usersService: UsersService,
    private jwtService: JwtService,
    private configService: ConfigService,
  ) {}

  /** -----------------------------------------------------------------------------------------------------
   * Generates new JWT access and refresh tokens for the user.
   * Saves a hashed version of the refresh token in the database.
   * @param {User} user - The user for whom tokens are generated.
   * @returns {Promise<{access_token: string, refresh_token: string}>} The generated access and refresh tokens.
   ----------------------------------------------------------------------------------------------------- **/
  async generateTokens(
    user: User,
  ): Promise<{ access_token: string; refresh_token: string }> {
    const accessPayload = { sub: user.id };

    const loginAt = user.lastLoginAt?.getTime() ?? Date.now();
    const refreshPayload = { sub: user.id, lastLoginAt: loginAt };

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
    };
  }

  /** -----------------------------------------------------------------------------------------------------
   * Refreshes the user's access token using their last login timestamp.
   * @param {any} user - The user requesting a token refresh.
   * @returns {Promise<{access_token: string}>} The newly generated access token.
   * @throws {UnauthorizedException} If the session has expired or the account is inactive.
   ----------------------------------------------------------------------------------------------------- **/
  async refreshToken(user: any): Promise<{ access_token: string }> {
    const sevenDays = 7 * 24 * 60 * 60 * 1000;

    if (!user.lastLoginAt || Date.now() - user.lastLoginAt > sevenDays) {
      throw new UnauthorizedException({
        message: ErrorCode.AUTH_SESSION_EXPIRED,
      });
    }

    const dbUser = await this.usersService.findById(user.id);

    if (!dbUser || !dbUser.isActive) {
      throw new UnauthorizedException({
        message: ErrorCode.AUTH_ACCOUNT_DISABLED,
      });
    }

    return this.generateTokens(dbUser);
  }

  /** -----------------------------------------------------------------------------------------------------
   * Authenticates a user with email and password.
   * @param {SignInDto} signInDto - User credentials.
   * @returns {Promise<{access_token: string, refresh_token: string}>} The generated access and refresh tokens.
   * @throws {UnauthorizedException} If credentials are invalid, the account is inactive, or the email is unverified.
   ----------------------------------------------------------------------------------------------------- **/
  async signIn(
    signInDto: SignInDto,
  ): Promise<{ access_token: string; refresh_token: string }> {
    const user = await this.usersService.findByEmail(signInDto.email);

    const passwordHash = user?.password ?? '$2b$10$invalidhashstring';
    const passwordValid = await bcrypt.compare(
      signInDto.password,
      passwordHash,
    );

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

    if (!user.emailVerified) {
      throw new UnauthorizedException({
        message: ErrorCode.AUTH_EMAIL_NOT_VERIFIED,
      });
    }

    await this.usersService.updateLastLogin(user.id);
    user.lastLoginAt = new Date();

    return await this.generateTokens(user);
  }

  /** -----------------------------------------------------------------------------------------------------
   * Signs out the user by removing their stored refresh token.
   * @param {any} user - The user signing out.
   ----------------------------------------------------------------------------------------------------- **/
  async signOut(user: any) {
    await this.usersService.updateRefreshToken(user.id, null);
  }

  /** -----------------------------------------------------------------------------------------------------
   * Registers a new user and generates access and refresh tokens.
   * @param {SignUpDto} body - User registration data.
   * @returns {Promise<{access_token: string, refresh_token: string}>} The generated access and refresh tokens.
   * @throws {ConflictException} If the email is already in use.
   * @throws {InternalServerErrorException} If an error occurs during user creation.
   ----------------------------------------------------------------------------------------------------- **/
  async signUp(
    body: SignUpDto,
  ): Promise<{ access_token: string; refresh_token: string }> {
    const user = await this.usersService.findByEmail(body.email);

    if (user) {
      throw new ConflictException({
        message: ErrorCode.AUTH_USER_ALREADY_EXISTS,
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

    return await this.generateTokens(newUser);
  }
}
