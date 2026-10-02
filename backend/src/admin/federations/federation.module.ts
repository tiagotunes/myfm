import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Federation } from '@/admin/federations/federation.entity';
import { FederationService } from '@/admin/federations/federation.service';
import { FederationController } from '@/admin/federations/federation.controller';

@Module({
  imports: [TypeOrmModule.forFeature([Federation])],
  controllers: [FederationController],
  providers: [FederationService],
  exports: [FederationService],
})
export class FederationModule {}
