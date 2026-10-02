import { Module } from '@nestjs/common';
import { DatabaseModule } from '@/database/database.module';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from '@/auth/auth.module';
import { UsersModule } from '@/users/users.module';
import { APP_GUARD } from '@nestjs/core';
import { AccessTokenGuard } from '@/auth/guards/token.guard';
import { AccessTokenJwtStrategy } from '@/auth/strategies/access-jwt.strategy';
import { FederationModule } from './admin/federations/federation.module';
import { ContinentModule } from './admin/continents/continent.module';
import { NationModule } from './admin/nations/nation.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    DatabaseModule,
    AuthModule,
    UsersModule,
    FederationModule,
    ContinentModule,
    NationModule,
  ],
  controllers: [],
  providers: [
    { provide: APP_GUARD, useClass: AccessTokenGuard },
    AccessTokenJwtStrategy,
  ],
})
export class AppModule {}
