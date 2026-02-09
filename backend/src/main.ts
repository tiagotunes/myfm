import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { BadRequestException, ValidationPipe } from '@nestjs/common';
import { LoggingService } from './modules/logging/logging.service';
import { GlobalExceptionFilter } from './common/filters/global-exception.filter';
import { ErrorCode } from './common/errors/error-codes';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
      transform: true,
      exceptionFactory: (errors) => {
        return new BadRequestException({
          code: ErrorCode.VALIDATION_ERROR,
          message: errors.flatMap((err) =>
            Object.values(err.constraints ?? {}),
          ),
        });
      },
    }),
  );

  const loggingService = app.get(LoggingService);
  app.useGlobalFilters(new GlobalExceptionFilter(loggingService));

  await app.listen(process.env.PORT ?? 3000);
}
bootstrap();
