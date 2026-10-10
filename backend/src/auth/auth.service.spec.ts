import * as bcrypt from 'bcrypt';
import { describe, beforeEach, it, expect, jest } from '@jest/globals';
import { Test, TestingModule } from '@nestjs/testing';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { ConflictException, UnauthorizedException } from '@nestjs/common';

import { AuthService } from '@/auth/auth.service';
import { UserService } from '@/users/user.service';
import { User } from '@/users/user.entity';

jest.mock('bcrypt', () => ({
  hash: jest.fn(),
  compare: jest.fn(),
}));

describe('AuthService', () => {
  let service: AuthService;

  const updateRefreshTokenMock =
    jest.fn<(userId: string, hash: string | null) => Promise<void>>();
  const findByEmailMock =
    jest.fn<
      (email: string) => Promise<import('@/users/user.entity').User | null>
    >();
  const findByEmailForAuthenticationMock =
    jest.fn<(email: string) => Promise<User | null>>();
  const updateLastLoginMock = jest.fn<(userId: string) => Promise<void>>();
  const signAsyncMock =
    jest.fn<(payload: object, options: object) => Promise<string>>();
  const getOrThrowMock = jest.fn<(key: string) => string>();
  const findByIdMock = jest.fn<(userId: string) => Promise<User | null>>();
  const createUserMock = jest.fn<(user: Partial<User>) => Promise<User>>();
  const bcryptHashMock = jest.mocked(bcrypt.hash);

  beforeEach(async () => {
    jest.mocked(bcrypt.compare).mockReset();
    updateRefreshTokenMock.mockReset();
    findByEmailMock.mockReset();
    findByEmailForAuthenticationMock.mockReset();
    updateLastLoginMock.mockReset();
    signAsyncMock.mockReset();
    getOrThrowMock.mockReset();
    findByIdMock.mockReset();
    createUserMock.mockReset();
    bcryptHashMock.mockReset();

    const usersServiceMock = {
      updateRefreshToken: updateRefreshTokenMock,
      findByEmail: findByEmailMock,
      findByEmailForAuthentication: findByEmailForAuthenticationMock,
      updateLastLogin: updateLastLoginMock,
      findById: findByIdMock,
      create: createUserMock,
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        AuthService,
        {
          provide: UserService,
          useValue: usersServiceMock,
        },
        {
          provide: JwtService,
          useValue: { signAsync: signAsyncMock },
        },
        {
          provide: ConfigService,
          useValue: { getOrThrow: getOrThrowMock },
        },
      ],
    }).compile();

    service = module.get<AuthService>(AuthService);
  });

  //#region Sign Out
  it('signOut clears the stored refresh token', async () => {
    updateRefreshTokenMock.mockResolvedValue(undefined);

    await service.signOut({ id: 'user-123' });

    expect(updateRefreshTokenMock).toHaveBeenCalledWith('user-123', null);
  });
  //#endregion

  //#region Sign Up
  it('signUp rejects an email that already exists', async () => {
    findByEmailMock.mockResolvedValue({ id: 'user-123' } as User);

    await expect(
      service.signUp({
        email: 'existing@example.com',
        password: '123qweASD!',
        name: 'Existing User',
      }),
    ).rejects.toBeInstanceOf(ConflictException);

    expect(findByEmailMock).toHaveBeenCalledWith('existing@example.com');
    expect(updateRefreshTokenMock).not.toHaveBeenCalled();
  });

  it('signUp creates a user and returns tokens', async () => {
    findByEmailMock.mockResolvedValue(null);
    bcryptHashMock.mockResolvedValue('hashed-password');
    const createdUser = {
      id: 'user-456',
      email: 'new@example.com',
      password: 'hashed-password',
      name: 'New User',
      isActive: true,
      role: 'user',
    } as User;
    createUserMock.mockResolvedValue(createdUser);
    getOrThrowMock.mockImplementation((key: string) => {
      const values: Record<string, string> = {
        JWT_ACCESS_TOKEN_SECRET: 'test-access-secret',
        JWT_ACCESS_TOKEN_EXPIRY: '12h',
        JWT_REFRESH_TOKEN_SECRET: 'test-refresh-secret',
        JWT_REFRESH_TOKEN_EXPIRY: '7d',
      };
      return values[key];
    });
    signAsyncMock
      .mockResolvedValueOnce('signup-access-token')
      .mockResolvedValueOnce('signup-refresh-token');
    bcryptHashMock
      .mockResolvedValueOnce('hashed-password')
      .mockResolvedValueOnce('hashed-refresh-token');
    updateRefreshTokenMock.mockResolvedValue(undefined);
    const result = await service.signUp({
      email: 'new@example.com',
      password: '123qweASD!',
      name: 'New User',
    });
    expect(bcryptHashMock).toHaveBeenCalledWith('123qweASD!', 10);
    expect(createUserMock).toHaveBeenCalledWith(
      expect.objectContaining({
        email: 'new@example.com',
        password: 'hashed-password',
        name: 'New User',
      }),
    );
    expect(result).toEqual({
      access_token: 'signup-access-token',
      refresh_token: 'signup-refresh-token',
      role: 'user',
    });
    expect(updateRefreshTokenMock).toHaveBeenCalledWith(
      'user-456',
      'hashed-refresh-token',
    );
  });
  //#endregion

  //#region Sign In
  it('signIn rejects invalid credentials', async () => {
    findByEmailForAuthenticationMock.mockResolvedValue(null);

    await expect(
      service.signIn({
        email: 'unknown@example.com',
        password: 'wrong-password',
      }),
    ).rejects.toBeInstanceOf(UnauthorizedException);

    expect(findByEmailForAuthenticationMock).toHaveBeenCalledWith(
      'unknown@example.com',
    );
  });

  it('signIn rejects a disabled account', async () => {
    const user = {
      id: 'user-123',
      email: 'disabled@example.com',
      password: 'stored-password-hash',
      isActive: false,
    } as User;

    findByEmailForAuthenticationMock.mockResolvedValue(user);

    jest.mocked(bcrypt.compare).mockResolvedValue(true);

    await expect(
      service.signIn({
        email: 'disabled@example.com',
        password: '123qweASD!',
      }),
    ).rejects.toBeInstanceOf(UnauthorizedException);

    expect(updateRefreshTokenMock).not.toHaveBeenCalled();
  });

  it('signIn returns tokens for valid credentials', async () => {
    const user = {
      id: 'user-123',
      email: 'valid@example.com',
      password: 'stored-password-hash',
      isActive: true,
      role: 'user',
    } as User;

    findByEmailForAuthenticationMock.mockResolvedValue(user);
    jest.mocked(bcrypt.compare).mockResolvedValue(true);
    updateLastLoginMock.mockResolvedValue(undefined);

    getOrThrowMock.mockImplementation((key: string) => {
      const values: Record<string, string> = {
        JWT_ACCESS_TOKEN_SECRET: 'test-access-secret',
        JWT_ACCESS_TOKEN_EXPIRY: '12h',
        JWT_REFRESH_TOKEN_SECRET: 'test-refresh-secret',
        JWT_REFRESH_TOKEN_EXPIRY: '7d',
      };

      return values[key];
    });

    signAsyncMock
      .mockResolvedValueOnce('test-access-token')
      .mockResolvedValueOnce('test-refresh-token');

    bcryptHashMock.mockResolvedValue('hashed-refresh-token');
    updateRefreshTokenMock.mockResolvedValue(undefined);

    const result = await service.signIn({
      email: 'valid@example.com',
      password: '123qweASD!',
    });

    expect(result).toEqual({
      access_token: 'test-access-token',
      refresh_token: 'test-refresh-token',
      role: 'user',
    });

    expect(updateLastLoginMock).toHaveBeenCalledWith('user-123');
    expect(updateRefreshTokenMock).toHaveBeenCalledWith(
      'user-123',
      'hashed-refresh-token',
    );
    expect(signAsyncMock).toHaveBeenCalledTimes(2);
  });
  //#endregion

  //#region Refresh Token
  it('refreshToken rejects a user who no longer exists', async () => {
    findByIdMock.mockResolvedValue(null);

    await expect(
      service.refreshToken({ id: 'missing-user' }),
    ).rejects.toBeInstanceOf(UnauthorizedException);

    expect(findByIdMock).toHaveBeenCalledWith('missing-user');
    expect(updateRefreshTokenMock).not.toHaveBeenCalled();
  });

  it('refreshToken rejects a disabled account', async () => {
    findByIdMock.mockResolvedValue({
      id: 'user-123',
      isActive: false,
    } as User);

    await expect(
      service.refreshToken({ id: 'user-123' }),
    ).rejects.toBeInstanceOf(UnauthorizedException);

    expect(findByIdMock).toHaveBeenCalledWith('user-123');
    expect(updateRefreshTokenMock).not.toHaveBeenCalled();
  });

  it('refreshToken allows a session beyond six days when the account is active', async () => {
    const user = {
      id: 'user-123',
      isActive: true,
      lastLoginAt: new Date(Date.now() - 8 * 24 * 60 * 60 * 1000),
      role: 'user',
    } as User;
    findByIdMock.mockResolvedValue(user);
    getOrThrowMock.mockImplementation((key: string) => {
      const values: Record<string, string> = {
        JWT_ACCESS_TOKEN_SECRET: 'test-access-secret',
        JWT_ACCESS_TOKEN_EXPIRY: '12h',
        JWT_REFRESH_TOKEN_SECRET: 'test-refresh-secret',
        JWT_REFRESH_TOKEN_EXPIRY: '7d',
      };
      return values[key];
    });
    signAsyncMock
      .mockResolvedValueOnce('new-access-token')
      .mockResolvedValueOnce('new-refresh-token');
    bcryptHashMock.mockResolvedValue('new-refresh-token-hash');
    updateRefreshTokenMock.mockResolvedValue(undefined);
    const result = await service.refreshToken({ id: 'user-123' });
    expect(result).toEqual({
      access_token: 'new-access-token',
      refresh_token: 'new-refresh-token',
      role: 'user',
    });
    expect(findByIdMock).toHaveBeenCalledWith('user-123');
  });

  it('refreshToken rotates tokens for a valid session', async () => {
    const user = {
      id: 'user-123',
      isActive: true,
      lastLoginAt: new Date(),
      role: 'user',
    } as User;

    findByIdMock.mockResolvedValue(user);

    getOrThrowMock.mockImplementation((key: string) => {
      const values: Record<string, string> = {
        JWT_ACCESS_TOKEN_SECRET: 'test-access-secret',
        JWT_ACCESS_TOKEN_EXPIRY: '12h',
        JWT_REFRESH_TOKEN_SECRET: 'test-refresh-secret',
        JWT_REFRESH_TOKEN_EXPIRY: '7d',
      };

      return values[key];
    });

    signAsyncMock
      .mockResolvedValueOnce('new-access-token')
      .mockResolvedValueOnce('new-refresh-token');

    bcryptHashMock.mockResolvedValue('new-refresh-token-hash');
    updateRefreshTokenMock.mockResolvedValue(undefined);

    const result = await service.refreshToken({ id: 'user-123' });

    expect(result).toEqual({
      access_token: 'new-access-token',
      refresh_token: 'new-refresh-token',
      role: 'user',
    });

    expect(signAsyncMock).toHaveBeenCalledTimes(2);
    expect(updateRefreshTokenMock).toHaveBeenCalledWith(
      'user-123',
      'new-refresh-token-hash',
    );
  });

  it('refreshToken allows a session without lastLoginAt when the account is active', async () => {
    const user = {
      id: 'user-123',
      isActive: true,
      lastLoginAt: null,
      role: 'user',
    } as User;
    findByIdMock.mockResolvedValue(user);
    getOrThrowMock.mockImplementation((key: string) => {
      const values: Record<string, string> = {
        JWT_ACCESS_TOKEN_SECRET: 'test-access-secret',
        JWT_ACCESS_TOKEN_EXPIRY: '12h',
        JWT_REFRESH_TOKEN_SECRET: 'test-refresh-secret',
        JWT_REFRESH_TOKEN_EXPIRY: '7d',
      };
      return values[key];
    });
    signAsyncMock
      .mockResolvedValueOnce('new-access-token')
      .mockResolvedValueOnce('new-refresh-token');
    bcryptHashMock.mockResolvedValue('new-refresh-token-hash');
    updateRefreshTokenMock.mockResolvedValue(undefined);
    const result = await service.refreshToken({ id: 'user-123' });
    expect(result).toEqual({
      access_token: 'new-access-token',
      refresh_token: 'new-refresh-token',
      role: 'user',
    });
    expect(findByIdMock).toHaveBeenCalledWith('user-123');
  });
  //#endregion
});
