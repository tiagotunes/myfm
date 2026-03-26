import 'dotenv/config';
import { DataSource } from 'typeorm';
import { DataSourceOptions } from 'typeorm/browser';

export const dataSourceOptions: DataSourceOptions = {
  type: 'mysql',
  host: process.env.MYSQL_HOST,
  port: parseInt(process.env.MYSQL_PORT || '3306'),
  username: process.env.MYSQL_USER,
  password: process.env.MYSQL_PASSWORD,
  database: process.env.MYSQL_DATABASE,

  entities: ['dist/**/*.entity.js'],
  migrations: ['dist/database/migrations/*.js'],
  migrationsTableName: 'migrations',

  invalidWhereValuesBehavior: {
    null: 'sql-null',
  },
};

const dataSource = new DataSource(dataSourceOptions);
export default dataSource;
