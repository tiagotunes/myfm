import { INestApplication } from '@nestjs/common';
import { Test, TestingModule } from '@nestjs/testing';
import request from 'supertest';
import { App } from 'supertest/types';
import { AppModule } from './../src/app.module';

describe('Application (e2e)', () => {
  let app: INestApplication<App>;

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    app.setGlobalPrefix('api/v1');

    await app.init();
  });

  afterAll(async () => {
    await app.close();
  });

  it('should return the health status', () => {
    return request(app.getHttpServer())
      .get('/api/v1/health')
      .expect(200)
      .expect({
        status: 'ok',
      });
  });

  it('should return 404 for an undefined route', () => {
    return request(app.getHttpServer()).get('/').expect(404);
  });
});
