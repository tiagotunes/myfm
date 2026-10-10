import { UserRole } from '@/users/user.entity';
export interface AuthenticatedUser {
  id: string;
  role: UserRole;
}
export interface JwtPayload {
  sub: string;
  role: UserRole;
}
