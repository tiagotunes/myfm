import { Injectable, UnauthorizedException } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ErrorCode } from '@/common/constants/error-codes';
import { AuthenticatedUser } from '@/auth/interfaces/auth.types';

@Injectable()
export class RefreshTokenGuard extends AuthGuard('jwt-refresh') {
  handleRequest<TUser = AuthenticatedUser>(
    err: any,
    user: TUser | null | undefined,
    info: any,
  ): TUser {
    void info;

    if (err || !user) {
      throw (
        err ||
        new UnauthorizedException({ message: ErrorCode.AUTH_INVALID_TOKEN })
      );
    }

    return user;
  }
}
