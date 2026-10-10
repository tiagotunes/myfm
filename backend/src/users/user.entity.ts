import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  UpdateDateColumn,
  Index,
  ManyToOne,
  JoinColumn,
} from 'typeorm';
import { Nation } from '@/admin/nations/nation.entity';

export enum UserRole {
  USER = 'user',
  ADMIN = 'admin',
}

@Entity('users')
export class User {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  /*--------------------------------------------------
  | AUTHENTICATION
  --------------------------------------------------*/
  @Index({ unique: true })
  @Column({ type: 'varchar', length: 255 })
  email: string;

  @Column({ type: 'varchar', length: 255, select: false })
  password: string;

  @Column({
    type: 'varchar',
    length: 255,
    name: 'refresh_token',
    nullable: true,
    select: false,
  })
  refreshToken: string | null;

  /*--------------------------------------------------
  | PROFILE
  --------------------------------------------------*/
  @Column({ type: 'varchar', length: 128 })
  name: string;

  @Column({ type: 'varchar', length: 1024, nullable: true })
  bio: string | null;

  @ManyToOne(() => Nation)
  @JoinColumn({ name: 'nation_id' })
  nation?: Nation | null;

  /*--------------------------------------------------
  | PREFERENCES
  --------------------------------------------------*/
  @Column({ type: 'varchar', length: 5, nullable: true })
  language: string | null;

  @Column({ type: 'varchar', length: 12, default: 'system' })
  theme: 'light' | 'dark' | 'system';

  /*--------------------------------------------------
  | AUTHORIZATION
  --------------------------------------------------*/
  @Column({
    type: 'enum',
    enum: UserRole,
    default: UserRole.USER,
  })
  role: UserRole;

  /*--------------------------------------------------
  | ACCOUNT STATUS
  --------------------------------------------------*/
  @Column({ name: 'email_verified', default: false })
  emailVerified: boolean;

  @Column({ name: 'is_active', default: true })
  isActive: boolean;

  @Column({ type: 'datetime', name: 'last_login_at', nullable: true })
  lastLoginAt: Date | null;

  /*--------------------------------------------------
  | AUDIT
  --------------------------------------------------*/
  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;

  @UpdateDateColumn({ name: 'updated_at' })
  updatedAt: Date;

  constructor(user: Partial<User>) {
    Object.assign(this, user);
  }
}
