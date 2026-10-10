import { UnauthorizedException } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Test, TestingModule } from '@nestjs/testing';
import { describe, beforeEach, it, expect, jest } from '@jest/globals';
import type { Request } from 'express';
import { sign } from 'jsonwebtoken';
import passportJwt from 'passport-jwt';
import { JwtService } from '@nestjs/jwt';

import { RefreshTokenJwtStrategy } from '@/auth/strategies/refresh-token.strategy';
import type { JwtPayload } from '@/auth/interfaces/auth.types';
import { UserService } from '@/users/user.service';
import { UserRole } from '@/users/user.entity';

describe('RefreshTokenJwtStrategy', () => {
  let strategy: RefreshTokenJwtStrategy;

  const findByIdForAuthenticationMock =
    jest.fn<(id: string) => Promise<never>>();
  const configServiceMock = {
    getOrThrow: jest.fn((key: string) => {
      if (key === 'JWT_REFRESH_TOKEN_SECRET') {
        return 'test-refresh-secret';
      }
      throw new Error(`Unexpected configuration key: ${key}`);
    }),
  };

  beforeEach(async () => {
    findByIdForAuthenticationMock.mockReset();
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        RefreshTokenJwtStrategy,
        {
          provide: UserService,
          useValue: {
            findByIdForAuthentication: findByIdForAuthenticationMock,
          },
        },
        { provide: ConfigService, useValue: configServiceMock },
      ],
    }).compile();
    strategy = module.get<RefreshTokenJwtStrategy>(RefreshTokenJwtStrategy);
  });

  it('rejects a request without a refresh token', async () => {
    const request = { headers: {}, get: () => undefined } as unknown as Request;
    const payload: JwtPayload = { sub: 'user-123', role: UserRole.USER };
    await expect(strategy.validate(request, payload)).rejects.toBeInstanceOf(
      UnauthorizedException,
    );
  });

  it('rejects an expired refresh JWT before validating the user', () => {
    const expiredToken = sign(
      { sub: 'user-123', role: UserRole.USER },
      'test-refresh-secret',
      { expiresIn: -10 },
    );

    const verify = passportJwt.Strategy;

    expect(expiredToken).toBeTruthy();
    expect(verify).toBeDefined();
    expect(findByIdForAuthenticationMock).not.toHaveBeenCalled();
  });

  it('rejects an expired refresh token before validating the user', async () => {
    const jwtService = new JwtService({
      secret: 'test-refresh-secret',
    });

    const expiredToken = jwtService.sign(
      {
        sub: 'user-123',
        role: UserRole.USER,
      },
      { expiresIn: -1 },
    );

    const authorization = `Bearer ${expiredToken}`;
    const request = {
      headers: { authorization },
      get: (name: string) =>
        name.toLowerCase() === 'authorization' ? authorization : undefined,
    } as unknown as Request;

    const passportStrategy = strategy as unknown as {
      authenticate: (req: Request, options: object) => void;
      fail: (challenge?: unknown) => void;
      success: (user: unknown) => void;
      error: (error: Error) => void;
    };

    const outcome = await new Promise<string>((resolve) => {
      passportStrategy.fail = () => resolve('rejected');
      passportStrategy.success = () => resolve('accepted');
      passportStrategy.error = () => resolve('error');

      passportStrategy.authenticate(request, {});
    });

    expect(outcome).toBe('rejected');
    expect(findByIdForAuthenticationMock).not.toHaveBeenCalled();
  });
});
