import {
  Column,
  CreateDateColumn,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { Continent } from '@/admin/continents/continent.entity';
import { Federation } from '@/admin/federations/federation.entity';

@Entity('nations')
export class Nation {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'varchar', length: 128 })
  name: string;

  @Column({ type: 'varchar', length: 128, nullable: true })
  demonym: string | null;

  @Column({ type: 'varchar', length: 2, unique: true })
  cca2: string;

  @ManyToOne(() => Continent, { nullable: false })
  @JoinColumn({ name: 'continent_id' })
  continent: Continent;

  @ManyToOne(() => Federation, { nullable: false })
  @JoinColumn({ name: 'federation_id' })
  federation: Federation;

  @Column({ name: 'is_active', default: true })
  isActive: boolean;

  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;

  @UpdateDateColumn({ name: 'updated_at', nullable: true })
  updatedAt?: Date | null;

  constructor(nation: Partial<Nation>) {
    Object.assign(this, nation);
  }
}
