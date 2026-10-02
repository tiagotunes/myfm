import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Continent } from '@/admin/continents/continent.entity';
import { Repository } from 'typeorm';
import { ErrorCode } from '@/common/constants/error-codes';

@Injectable()
export class ContinentService {
  constructor(
    @InjectRepository(Continent)
    private readonly continetnRepository: Repository<Continent>,
  ) {}

  async getAll(): Promise<Continent[] | null> {
    const continents = await this.continetnRepository.find({
      select: {
        id: true,
        name: true,
        createdAt: true,
        updatedAt: true,
      },
      order: { name: 'ASC' },
    });

    if (!continents) {
      throw new NotFoundException({
        message: ErrorCode.CONTINENT_NOT_FOUND,
      });
    }
    return continents;
  }

  async getCount(): Promise<Number | null> {
    const nContinents = await this.continetnRepository.count();
    return nContinents;
  }
}
