import { DataSource } from 'typeorm';
import { NestFactory } from '@nestjs/core';
import { AppModule } from '@/app.module';

import { Federation } from '@/admin/federations/federation.entity';
import { Continent } from '@/admin/continents/continent.entity';
import { Nation } from '@/admin/nations/nation.entity';

import { federationSeed } from '@/database/seeds/federation.seed';
import { continentSeed } from '@/database/seeds/continent.seed';
import { nationSeed } from '@/database/seeds/nation.seed';

async function bootstrap() {
  const app = await NestFactory.createApplicationContext(AppModule);
  const dataSource = app.get(DataSource);

  const federationRepo = dataSource.getRepository(Federation);
  const continentRepo = dataSource.getRepository(Continent);
  const nationRepo = dataSource.getRepository(Nation);

  // -------------------------
  // 1. SEED FEDERATIONS
  // -------------------------
  await federationRepo.upsert(federationSeed, ['acronym']);
  console.log('Federations seeded');

  const federations = await federationRepo.find();
  const federationMap = Object.fromEntries(
    federations.map((f) => [f.acronym, f]),
  );

  // -------------------------
  // 2. SEED CONTINENTS
  // -------------------------
  const continentsWithRelations = continentSeed.map((c) => ({
    name: c.name,
  }));

  await continentRepo.upsert(continentsWithRelations, ['name']);
  console.log('Continents seeded');

  const continents = await continentRepo.find();
  const continentMap = Object.fromEntries(continents.map((c) => [c.name, c]));

  // -------------------------
  // 3. SEED NATIONS
  // -------------------------
  const nationsWithRelations = nationSeed.map((n) => ({
    name: n.name,
    demonym: n.demonym,
    cca2: n.cca2,
    continent: continentMap[n.continent],
    federation: federationMap[n.federation],
  }));

  await nationRepo.upsert(nationsWithRelations, ['cca2']);
  console.log('Nations seeded');

  await app.close();
}

void bootstrap().catch((error: unknown) => {
  console.error('Database seeding failed:', error);
  process.exitCode = 1;
});
