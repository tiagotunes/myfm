import { Injectable, UnauthorizedException } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PassportStrategy } from '@nestjs/passport';
import * as bcrypt from 'bcrypt';
import { Request } from 'express';
import { ExtractJwt, Strategy } from 'passport-jwt';

import { ErrorCode } from '@/common/constants/error-codes';
import { JwtPayload } from '@/auth/interfaces/auth.types';
import { UserService } from '@/users/user.service';
import { UserRole } from '@/users/user.entity';

@Injectable()
export class RefreshTokenJwtStrategy extends PassportStrategy(
  Strategy,
  'jwt-refresh',
) {
  constructor(
    private readonly usersService: UserService,
    private readonly configService: ConfigService,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: configService.getOrThrow('JWT_REFRESH_TOKEN_SECRET'),
      passReqToCallback: true,
      ignoreExpiration: false,
    });
  }

  async validate(
    req: Request,
    payload: JwtPayload,
  ): Promise<{ id: string; role: UserRole }> {
    const refreshToken = ExtractJwt.fromAuthHeaderAsBearerToken()(req);

    if (!refreshToken) {
      throw new UnauthorizedException({
        message: ErrorCode.AUTH_INVALID_TOKEN,
      });
    }

    const user = await this.usersService.findByIdForAuthentication(payload.sub);
    if (!user || !user.refreshToken) {
      throw new UnauthorizedException({
        message: ErrorCode.AUTH_INVALID_TOKEN,
      });
    }

    const refreshTokenMatches = await bcrypt.compare(
      refreshToken,
      user.refreshToken,
    );

    if (!refreshTokenMatches) {
      throw new UnauthorizedException({
        message: ErrorCode.AUTH_INVALID_TOKEN,
      });
    }

    return { id: user.id, role: user.role };
  }
}
