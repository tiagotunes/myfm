import * as Joi from 'joi';
import { Module } from '@nestjs/common';
import { DatabaseModule } from '@/database/database.module';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from '@/auth/auth.module';
import { UserModule } from '@/users/user.module';
import { APP_GUARD } from '@nestjs/core';
import { AccessTokenGuard } from '@/auth/guards/access-token.guard';
import { AccessTokenJwtStrategy } from '@/auth/strategies/access-token.strategy';
import { FederationModule } from '@/admin/federations/federation.module';
import { ContinentModule } from '@/admin/continents/continent.module';
import { NationModule } from '@/admin/nations/nation.module';
import { HealthController } from './health/health.controller';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      cache: true,
      validationSchema: Joi.object({
        NODE_ENV: Joi.string()
          .valid('development', 'production', 'test')
          .default('development'),

        PORT: Joi.number().port().default(3000),

        MYSQL_HOST: Joi.string().required(),
        MYSQL_PORT: Joi.number().port().default(3306),
        MYSQL_DATABASE: Joi.string().required(),
        MYSQL_USER: Joi.string().required(),
        MYSQL_PASSWORD: Joi.string().required(),

        JWT_ACCESS_TOKEN_SECRET: Joi.string().min(32).required(),
        JWT_ACCESS_TOKEN_EXPIRY: Joi.string().required(),

        JWT_REFRESH_TOKEN_SECRET: Joi.string().min(32).required(),
        JWT_REFRESH_TOKEN_EXPIRY: Joi.string().required(),
      }),
    }),
    DatabaseModule,
    AuthModule,
    UserModule,
    FederationModule,
    ContinentModule,
    NationModule,
  ],
  controllers: [HealthController],
  providers: [
    { provide: APP_GUARD, useClass: AccessTokenGuard },
    AccessTokenJwtStrategy,
  ],
})
export class AppModule {}
