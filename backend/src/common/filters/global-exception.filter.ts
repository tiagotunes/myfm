import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
  HttpStatus,
} from '@nestjs/common';
import { Request, Response } from 'express';
import { LoggingService } from '../../modules/logging/logging.service';
import { ErrorCode } from '../errors/error-codes';
import { HttpMethod } from '../../modules/logging/entities/error-log.entity';

@Catch()
export class GlobalExceptionFilter implements ExceptionFilter {
  constructor(private readonly loggingService: LoggingService) {}

  async catch(exception: unknown, host: ArgumentsHost): Promise<void> {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();

    let status = HttpStatus.INTERNAL_SERVER_ERROR;
    let message = ErrorCode.INTERNAL_SERVER_ERROR;

    if (exception instanceof HttpException) {
      status = exception.getStatus();
      const responseBody = exception.getResponse();

      if (typeof responseBody === 'object' && responseBody !== null) {
        const body = responseBody as any;

        if (Array.isArray(body.message)) {
          message = body.message[0];
        } else if (typeof body.message === 'string') {
          message = body.message;
        }
      }
    }

    // Log only server errors
    if (status >= 500) {
      await this.loggingService.logError({
        source: 'GlobalExceptionFilter',
        method: request.method as HttpMethod,
        path: request.url,
        status,
        errorMessage: message,
        stack: exception instanceof Error ? exception.stack : undefined,
        requestBody: request.path.includes('/auth/login')
          ? undefined
          : request.body,
        requestParams: {
          query: request.query,
          params: request.params,
        },
        userId: (request as any)?.user?.userId,
        ipAddress: request.ip,
        userAgent: request.headers['user-agent'],
      });
    }

    response.status(status).json({
      status,
      message,
    });
  }
}
