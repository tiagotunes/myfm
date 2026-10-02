import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';

@Entity('continents')
export class Continent {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ unique: true })
  name: string;

  @Column({ name: 'is_active', default: true })
  isActive: boolean;

  /*--------------------------------------------------
  | AUDIT                                            |
  --------------------------------------------------*/
  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;

  @UpdateDateColumn({ name: 'updated_at', nullable: true })
  updatedAt?: Date;

  constructor(continent: Partial<Continent>) {
    Object.assign(this, continent);
  }
}
