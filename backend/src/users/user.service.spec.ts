import { describe, beforeEach, it, expect, jest } from '@jest/globals';
import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { FindOneOptions, UpdateResult } from 'typeorm';

import { User } from '@/users/user.entity';
import { UserService } from '@/users/user.service';

describe('UserService', () => {
  let service: UserService;

  const findOneMock =
    jest.fn<(options: FindOneOptions<User>) => Promise<User | null>>();
  const updateMock =
    jest.fn<(id: string, values: Partial<User>) => Promise<UpdateResult>>();

  beforeEach(async () => {
    findOneMock.mockReset();
    updateMock.mockReset();

    const repositoryMock = {
      findOne: findOneMock,
      update: updateMock,
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        UserService,
        {
          provide: getRepositoryToken(User),
          useValue: repositoryMock,
        },
      ],
    }).compile();

    service = module.get<UserService>(UserService);
  });

  it('findById returns the user matching the ID', async () => {
    const user = { id: 'user-123' } as User;

    findOneMock.mockResolvedValue(user);

    await expect(service.findById('user-123')).resolves.toBe(user);

    expect(findOneMock).toHaveBeenCalledWith({
      where: { id: 'user-123' },
    });
  });

  it('getInfo selects only the intended user fields and loads nation', async () => {
    const user = { id: 'user-123', email: 'test@example.com' } as User;

    findOneMock.mockResolvedValue(user);

    await expect(service.getInfo('user-123')).resolves.toBe(user);

    expect(findOneMock).toHaveBeenCalledWith({
      select: {
        id: true,
        email: true,
        name: true,
        bio: true,
        nation: {
          id: true,
          demonym: true,
          cca2: true,
        },
        language: true,
        theme: true,
        role: true,
        emailVerified: true,
        isActive: true,
        lastLoginAt: true,
        createdAt: true,
        updatedAt: true,
      },
      where: { id: 'user-123' },
      relations: ['nation'],
    });
  });

  it('findById returns null when the user does not exist', async () => {
    findOneMock.mockResolvedValue(null);

    await expect(service.findById('missing-user')).resolves.toBeNull();

    expect(findOneMock).toHaveBeenCalledWith({
      where: { id: 'missing-user' },
    });
  });

  it('updateRefreshToken stores the supplied hash for the user', async () => {
    updateMock.mockResolvedValue({ affected: 1, raw: [], generatedMaps: [] });

    await service.updateRefreshToken('user-123', 'hashed-refresh-token');

    expect(updateMock).toHaveBeenCalledWith('user-123', {
      refreshToken: 'hashed-refresh-token',
    });
  });

  it('updateRefreshToken clears the stored hash when passed null', async () => {
    updateMock.mockResolvedValue({ affected: 1, raw: [], generatedMaps: [] });

    await service.updateRefreshToken('user-123', null);

    expect(updateMock).toHaveBeenCalledWith('user-123', {
      refreshToken: null,
    });
  });
});
