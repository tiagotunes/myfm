import {
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { AuthGuard } from '@nestjs/passport';
import { ErrorCode } from '@/common/constants/error-codes';
import { PUBLIC_KEY } from '@/common/decorators/public.decorator';
import { AuthenticatedUser } from '@/auth/interfaces/auth.types';

@Injectable()
export class AccessTokenGuard extends AuthGuard('jwt') {
  constructor(private readonly reflector: Reflector) {
    super();
  }

  canActivate(context: ExecutionContext) {
    const isPublic = this.reflector.getAllAndOverride<boolean>(PUBLIC_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);

    if (isPublic) return true;
    return super.canActivate(context);
  }

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
