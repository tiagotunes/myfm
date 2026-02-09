import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ErrorLog } from './entities/error-log.entity';
import { LoggingService } from './logging.service';

@Module({
  imports: [TypeOrmModule.forFeature([ErrorLog])],
  providers: [LoggingService],
  exports: [LoggingService],
})
export class LoggingModule {}
