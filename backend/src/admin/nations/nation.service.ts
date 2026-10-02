import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Nation } from '@/admin/nations/nation.entity';
import { Repository } from 'typeorm';
import { ErrorCode } from '@/common/constants/error-codes';

@Injectable()
export class NationService {
  constructor(
    @InjectRepository(Nation)
    private readonly nationRepository: Repository<Nation>,
  ) {}

  async getAll(): Promise<Nation[] | null> {
    const nations = await this.nationRepository.find({
      select: {
        id: true,
        name: true,
        demonym: true,
        cca2: true,
        continent: { name: true },
        federation: { acronym: true, name: true },
        isActive: true,
        createdAt: true,
        updatedAt: true,
      },
      relations: ['continent', 'federation'],
      order: { name: 'ASC' },
    });

    if (!nations) {
      throw new NotFoundException({
        message: ErrorCode.NATION_NOT_FOUND,
      });
    }
    return nations;
  }

  async getCount(): Promise<Number | null> {
    const nNations = await this.nationRepository.count();
    return nNations;
  }
}
