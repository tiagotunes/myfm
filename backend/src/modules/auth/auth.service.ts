import { Injectable, UnauthorizedException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt';
import { User } from './entities/user.entity';
import { jwtConfig } from '../../config/jwt.config';
import { MeDto } from './dto/me.dto';
import { ErrorCode } from 'src/common/errors/error-codes';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(User)
    private readonly usersRepository: Repository<User>,
    private readonly jwtService: JwtService,
  ) {}

  async getMe(userId: string): Promise<MeDto> {
    const user = await this.usersRepository.findOne({
      where: { id: userId },
      select: ['id', 'email', 'displayName', 'role', 'isActive'],
    });

    if (!user) {
      throw new UnauthorizedException({
        code: ErrorCode.AUTH_INVALID_CREDENTIALS,
        message: ErrorCode.AUTH_INVALID_CREDENTIALS,
      });
    }

    return user;
  }

  async signIn(email: string, password: string) {
    const user = await this.usersRepository.findOne({
      where: { email },
    });

    if (!user) {
      throw new UnauthorizedException({
        code: ErrorCode.AUTH_INVALID_CREDENTIALS,
        message: ErrorCode.AUTH_INVALID_CREDENTIALS,
      });
    }

    const passwordValid = await bcrypt.compare(password, user.passwordHash);

    if (!passwordValid) {
      throw new UnauthorizedException({
        code: ErrorCode.AUTH_INVALID_CREDENTIALS,
        message: ErrorCode.AUTH_INVALID_CREDENTIALS,
      });
    }

    user.lastLoginAt = new Date();
    await this.usersRepository.save(user);

    const payload = { sub: user.id };
    const accessToken = this.jwtService.sign(payload, {
      expiresIn: Number(jwtConfig.accessTokenExpiresIn),
    });
    const refreshToken = this.jwtService.sign(payload, {
      expiresIn: Number(jwtConfig.refreshTokenExpiresIn),
    });

    return {
      access_token: accessToken,
      refresh_token: refreshToken,
    };
  }
}
