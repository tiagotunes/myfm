import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { ErrorLog, HttpMethod } from './entities/error-log.entity';

interface LogErrorParams {
  source: string;
  method: string;
  path: string;
  status: number;
  errorMessage: string;
  stack?: string;
  requestBody?: Record<string, any>;
  requestParams?: Record<string, any>;
  userId?: string;
  ipAddress?: string;
  userAgent?: string;
}

@Injectable()
export class LoggingService {
  constructor(
    @InjectRepository(ErrorLog)
    private readonly errorLogRepository: Repository<ErrorLog>,
  ) {}

  async logError(params: LogErrorParams): Promise<void> {
    try {
      const errorLog = this.errorLogRepository.create({
        source: params.source,
        method: params.method as HttpMethod,
        path: params.path,
        status: params.status,
        errorMessage: params.errorMessage,
        stack: params.stack,
        requestBody: params.requestBody,
        requestParams: params.requestParams,
        userId: params.userId,
        ipAddress: params.ipAddress,
        userAgent: params.userAgent,
      });

      await this.errorLogRepository.save(errorLog);
    } catch {}
  }
}
