import 'dotenv/config';
import { DataSource } from 'typeorm';
import { User } from './modules/auth/entities/user.entity';

export const AppDataSource = new DataSource({
  type: 'postgres',
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT),
  username: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  entities: [User],
  migrations: ['src/migrations/*.ts'],
  migrationsRun: true,
});
