import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';

@Entity('federations')
export class Federation {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ unique: true })
  acronym: string;

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

  constructor(federation: Partial<Federation>) {
    Object.assign(this, federation);
  }
}
