import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Continent } from '@/admin/continents/continent.entity';
import { ContinentController } from '@/admin/continents/continent.controller';
import { ContinentService } from '@/admin/continents/continent.service';

@Module({
  imports: [TypeOrmModule.forFeature([Continent])],
  controllers: [ContinentController],
  providers: [ContinentService],
  exports: [ContinentService],
})
export class ContinentModule {}
