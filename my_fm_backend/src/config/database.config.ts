import { TypeOrmModuleOptions } from '@nestjs/typeorm';
import { User } from '../modules/auth/entities/user.entity';

export const databaseConfig: TypeOrmModuleOptions = {
  type: 'postgres',
  host: 'localhost',
  port: 5432,
  username: 'fm_user',
  password: 'fm_password',
  database: 'my_fm_db',
  entities: [User],
  synchronize: true, // DEV ONLY
};
