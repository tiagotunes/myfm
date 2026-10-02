import {
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { AuthGuard } from '@nestjs/passport';
import { ErrorCode } from '@/common/constants/error-codes';
import { PUBLIC_KEY } from '@/common/decorators/public.decorator';

@Injectable()
export class AccessTokenGuard extends AuthGuard('jwt') {
  constructor(private reflector: Reflector) {
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

  handleRequest(err: any, user: any, _: any) {
    if (err || !user) {
      throw (
        err ||
        new UnauthorizedException({ message: ErrorCode.AUTH_INVALID_TOKEN })
      );
    }
    return user;
  }
}

@Injectable()
export class RefreshTokenGuard extends AuthGuard('jwt-refresh') {
  handleRequest(err: any, user: any, info: any) {
    if (err || !user) {
      throw (
        err ||
        new UnauthorizedException({ message: ErrorCode.AUTH_INVALID_TOKEN })
      );
    }
    return user;
  }
}
