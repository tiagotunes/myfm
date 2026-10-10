import {
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DeleteResult, Repository } from 'typeorm';
import { Federation } from '@/admin/federations/federation.entity';
import { ErrorCode } from '@/common/constants/error-codes';
import { CreateFederationDto } from '@/admin/federations/dtos/create-federation.dto';
import { UpdateFederationDto } from '@/admin/federations/dtos/update-federation.dto';

@Injectable()
export class FederationService {
  constructor(
    @InjectRepository(Federation)
    private readonly federationRepository: Repository<Federation>,
  ) {}

  async create(federation: CreateFederationDto): Promise<Federation | null> {
    let exists = await this.findByAcronym(federation.acronym);
    if (exists) {
      throw new ConflictException({
        message: ErrorCode.FEDERATION_ACRONYM_ALREAY_EXISTS,
      });
    }

    exists = await this.findByName(federation.name);
    if (exists) {
      throw new ConflictException({
        message: ErrorCode.FEDERATION_NAME_ALREAY_EXISTS,
      });
    }

    return await this.federationRepository.save(federation);
  }

  async delete(id: string): Promise<DeleteResult> {
    await this.getById(id);
    return await this.federationRepository.delete({ id });
  }

  async findByAcronym(acronym: string): Promise<Federation | null> {
    return await this.federationRepository.findOne({
      where: { acronym },
    });
  }

  async findByName(name: string): Promise<Federation | null> {
    return await this.federationRepository.findOne({
      where: { name },
    });
  }

  async getAll(): Promise<Federation[] | null> {
    const federations = await this.federationRepository.find({
      order: { acronym: 'ASC' },
    });

    if (!federations) {
      throw new NotFoundException({ message: ErrorCode.FEDERATION_NOT_FOUND });
    }
    return federations;
  }

  async getById(id: string): Promise<Federation | null> {
    const federation = await this.federationRepository.findOneBy({ id });

    if (!federation) {
      throw new NotFoundException({ message: ErrorCode.FEDERATION_NOT_FOUND });
    }
    return federation;
  }

  async getCount(): Promise<number | null> {
    const nFederations = await this.federationRepository.count();
    return nFederations;
  }

  async update(
    id: string,
    updatedFederation: UpdateFederationDto,
  ): Promise<Federation> {
    const federation = await this.getById(id);

    if (updatedFederation.acronym) {
      const exists = await this.findByAcronym(updatedFederation.acronym);
      if (exists) {
        throw new ConflictException({
          message: ErrorCode.FEDERATION_ACRONYM_ALREAY_EXISTS,
        });
      }
    }

    if (updatedFederation.name) {
      const exists = await this.findByName(updatedFederation.name);
      if (exists) {
        throw new ConflictException({
          message: ErrorCode.FEDERATION_NAME_ALREAY_EXISTS,
        });
      }
    }

    Object.assign(federation!, updatedFederation);

    return await this.federationRepository.save(federation!);
  }
}
