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

  @Column()
  name: string;

  @Column({ nullable: true })
  demonym: string;

  @Column({ length: 2, unique: true })
  cca2: string;

  @ManyToOne(() => Continent)
  @JoinColumn({ name: 'continent_id' })
  continent: Continent;

  @ManyToOne(() => Federation)
  @JoinColumn({ name: 'federation_id' })
  federation: Federation;

  @Column({ name: 'is_active', default: true })
  isActive: boolean;

  /*--------------------------------------------------
  | AUDIT                                            |
  --------------------------------------------------*/
  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;

  @UpdateDateColumn({ name: 'updated_at', nullable: true })
  updatedAt?: Date;

  constructor(nation: Partial<Nation>) {
    Object.assign(this, nation);
  }
}
