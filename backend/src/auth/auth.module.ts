import { Module } from '@nestjs/common';
import { AuthService } from '@/auth/auth.service';
import { AuthController } from '@/auth/auth.controller';
import { UserModule } from '@/users/user.module';
import { PassportModule } from '@nestjs/passport';
import { JwtModule } from '@nestjs/jwt';
import { RefreshTokenJwtStrategy } from '@/auth/strategies/refresh-jwt.strategy';

@Module({
  imports: [
    UserModule,
    PassportModule.register({ defaultStrategy: 'jwt', session: false }),
    JwtModule.register({}),
  ],
  controllers: [AuthController],
  providers: [AuthService, RefreshTokenJwtStrategy],
  exports: [AuthService],
})
export class AuthModule {}
