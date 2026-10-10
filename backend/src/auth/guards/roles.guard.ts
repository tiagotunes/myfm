import {
  CanActivate,
  ExecutionContext,
  ForbiddenException,
  Injectable,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { Request } from 'express';
import { ROLES_KEY } from '@/common/decorators/roles.decorator';
import { ErrorCode } from '@/common/constants/error-codes';
import { UserRole } from '@/users/user.entity';
import { AuthenticatedUser } from '@/auth/interfaces/auth.types';

type RequestWithUser = Request & {
  user?: AuthenticatedUser;
};

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private readonly reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const requiredRoles = this.reflector.getAllAndOverride<UserRole[]>(
      ROLES_KEY,
      [context.getHandler(), context.getClass()],
    );

    if (!requiredRoles) return true;

    const request = context.switchToHttp().getRequest<RequestWithUser>();
    const user = request.user;

    if (!user || !requiredRoles.includes(user.role)) {
      throw new ForbiddenException({
        message: ErrorCode.FORBIDDEN_EXCEPTION,
        requiredRoles,
        requestRole: user?.role ?? null,
      });
    }

    return true;
  }
}
