import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Federation } from '@/admin/federations/federation.entity';
import { FederationService } from '@/admin/federations/federation.service';
import { Continent } from '@/admin/continents/continent.entity';
import { ContinentService } from '@/admin/continents/continent.service';
import { Nation } from '@/admin/nations/nation.entity';
import { NationController } from '@/admin/nations/nation.controller';
import { NationService } from '@/admin/nations/nation.service';

@Module({
  imports: [TypeOrmModule.forFeature([Federation, Continent, Nation])],
  controllers: [NationController],
  providers: [FederationService, ContinentService, NationService],
  exports: [FederationService, ContinentService, NationService],
})
export class NationModule {}
