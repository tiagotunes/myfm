import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from '@/users/user.entity';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User)
    private readonly usersRepository: Repository<User>,
  ) {}

  async create(user: Partial<User>): Promise<User> {
    const newUser = this.usersRepository.create(user);
    return await this.usersRepository.save(newUser);
  }

  async findById(id: string): Promise<User | null> {
    return await this.usersRepository.findOne({
      where: { id },
    });
  }

  async findByIdForAuthentication(id: string): Promise<User | null> {
    return await this.usersRepository
      .createQueryBuilder('user')
      .addSelect(['user.password', 'user.refreshToken'])
      .where('user.id = :id', { id })
      .getOne();
  }

  async getInfo(id: string): Promise<User | null> {
    return await this.usersRepository.findOne({
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
      where: { id },
      relations: ['nation'],
    });
  }

  async findByEmail(email: string): Promise<User | null> {
    return await this.usersRepository.findOne({
      where: { email },
    });
  }

  async findByEmailForAuthentication(email: string): Promise<User | null> {
    return await this.usersRepository
      .createQueryBuilder('user')
      .addSelect(['user.password', 'user.refreshToken'])
      .where('user.email = :email', { email })
      .getOne();
  }

  async updateLastLogin(userId: string): Promise<void> {
    await this.usersRepository.update(userId, {
      lastLoginAt: new Date(),
    });
  }

  async updateRefreshToken(userId: string, hash: string | null): Promise<void> {
    await this.usersRepository.update(userId, {
      refreshToken: hash,
    });
  }
}
