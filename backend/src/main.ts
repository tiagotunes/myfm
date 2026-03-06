import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { BadRequestException, ValidationPipe } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalPipes(
    new ValidationPipe({
      forbidNonWhitelisted: true,
      stopAtFirstError: true,
      transform: true,
      whitelist: true,
      exceptionFactory: (errors) => {
        const error = errors.find((e) => e.constraints);
        const message = error
          ? Object.values(error.constraints!)[0]
          : 'VALIDATION_ERROR';
        return new BadRequestException({ message });
      },
    }),
  );
  await app.listen(process.env.PORT ?? 3000);
}
bootstrap();
