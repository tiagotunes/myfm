import { MigrationInterface, QueryRunner } from 'typeorm';

export class InitialSchema1790956808330 implements MigrationInterface {
  name = 'InitialSchema1790956808330';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `CREATE TABLE \`continents\` (\`id\` varchar(36) NOT NULL, \`name\` varchar(128) NOT NULL, \`is_active\` tinyint NOT NULL DEFAULT 1, \`created_at\` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6), \`updated_at\` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6), UNIQUE INDEX \`IDX_ae0a871c183ed3175997afc0ff\` (\`name\`), PRIMARY KEY (\`id\`)) ENGINE=InnoDB`,
    );
    await queryRunner.query(
      `CREATE TABLE \`federations\` (\`id\` varchar(36) NOT NULL, \`acronym\` varchar(16) NOT NULL, \`name\` varchar(128) NOT NULL, \`is_active\` tinyint NOT NULL DEFAULT 1, \`created_at\` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6), \`updated_at\` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6), UNIQUE INDEX \`IDX_f4a70f3bdf02ee7f4bddaf0f14\` (\`acronym\`), UNIQUE INDEX \`IDX_5d8d7110a353402c62620fbf9b\` (\`name\`), PRIMARY KEY (\`id\`)) ENGINE=InnoDB`,
    );
    await queryRunner.query(
      `CREATE TABLE \`nations\` (\`id\` varchar(36) NOT NULL, \`name\` varchar(128) NOT NULL, \`demonym\` varchar(128) NULL, \`cca2\` varchar(2) NOT NULL, \`is_active\` tinyint NOT NULL DEFAULT 1, \`created_at\` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6), \`updated_at\` datetime(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6), \`continent_id\` varchar(36) NOT NULL, \`federation_id\` varchar(36) NOT NULL, UNIQUE INDEX \`IDX_ece845d93eb648f81f0798dd9b\` (\`cca2\`), PRIMARY KEY (\`id\`)) ENGINE=InnoDB`,
    );
    await queryRunner.query(
      `CREATE TABLE \`users\` (\`id\` varchar(36) NOT NULL, \`email\` varchar(255) NOT NULL, \`password\` varchar(255) NOT NULL, \`refresh_token\` varchar(255) NULL, \`name\` varchar(128) NOT NULL, \`bio\` varchar(1024) NULL, \`language\` varchar(5) NULL, \`theme\` varchar(12) NOT NULL DEFAULT 'system', \`role\` enum ('user', 'admin') NOT NULL DEFAULT 'user', \`email_verified\` tinyint NOT NULL DEFAULT 0, \`is_active\` tinyint NOT NULL DEFAULT 1, \`last_login_at\` datetime NULL, \`created_at\` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6), \`updated_at\` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6), \`nation_id\` varchar(36) NULL, UNIQUE INDEX \`IDX_97672ac88f789774dd47f7c8be\` (\`email\`), PRIMARY KEY (\`id\`)) ENGINE=InnoDB`,
    );
    await queryRunner.query(
      `ALTER TABLE \`nations\` ADD CONSTRAINT \`FK_d86d387a9b8a919d934d21c0170\` FOREIGN KEY (\`continent_id\`) REFERENCES \`continents\`(\`id\`) ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE \`nations\` ADD CONSTRAINT \`FK_ef1eba5bf49f3144fce2bb37bd0\` FOREIGN KEY (\`federation_id\`) REFERENCES \`federations\`(\`id\`) ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE \`users\` ADD CONSTRAINT \`FK_a92b1a6e6877a76af3a76464211\` FOREIGN KEY (\`nation_id\`) REFERENCES \`nations\`(\`id\`) ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE \`users\` DROP FOREIGN KEY \`FK_a92b1a6e6877a76af3a76464211\``,
    );
    await queryRunner.query(
      `ALTER TABLE \`nations\` DROP FOREIGN KEY \`FK_ef1eba5bf49f3144fce2bb37bd0\``,
    );
    await queryRunner.query(
      `ALTER TABLE \`nations\` DROP FOREIGN KEY \`FK_d86d387a9b8a919d934d21c0170\``,
    );
    await queryRunner.query(
      `DROP INDEX \`IDX_97672ac88f789774dd47f7c8be\` ON \`users\``,
    );
    await queryRunner.query(`DROP TABLE \`users\``);
    await queryRunner.query(
      `DROP INDEX \`IDX_ece845d93eb648f81f0798dd9b\` ON \`nations\``,
    );
    await queryRunner.query(`DROP TABLE \`nations\``);
    await queryRunner.query(
      `DROP INDEX \`IDX_5d8d7110a353402c62620fbf9b\` ON \`federations\``,
    );
    await queryRunner.query(
      `DROP INDEX \`IDX_f4a70f3bdf02ee7f4bddaf0f14\` ON \`federations\``,
    );
    await queryRunner.query(`DROP TABLE \`federations\``);
    await queryRunner.query(
      `DROP INDEX \`IDX_ae0a871c183ed3175997afc0ff\` ON \`continents\``,
    );
    await queryRunner.query(`DROP TABLE \`continents\``);
  }
}
