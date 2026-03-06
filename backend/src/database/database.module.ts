import { Module } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [
    TypeOrmModule.forRootAsync({
      inject: [ConfigService],
      useFactory: (configService: ConfigService) => ({
        type: 'mysql',
        host: configService.getOrThrow('MYSQL_HOST'),
        port: configService.getOrThrow('MYSQL_PORT'),
        database: configService.getOrThrow('MYSQL_DATABASE'),
        username: configService.getOrThrow('MYSQL_USER'),
        password: configService.getOrThrow('MYSQL_PASSWORD'),
        invalidWhereValuesBehavior: {
          null: 'sql-null',
        },
        autoLoadEntities: true,
        synchronize: configService.get('NODE_ENV') !== 'PRD',
        // logging: configService.get('NODE_ENV') !== 'PRD',
      }),
    }),
  ],
})
export class DatabaseModule {}
