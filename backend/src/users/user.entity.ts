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
  | AUTHENTICATION                                   |
  --------------------------------------------------*/
  @Index({ unique: true })
  @Column()
  email: string;

  @Column()
  password: string;

  @Column({ type: 'varchar', name: 'refresh_token', nullable: true })
  refreshToken: string | null;

  /*--------------------------------------------------
  | PROFILE                                          |
  --------------------------------------------------*/
  @Column({ length: 64 })
  name: string;

  @Column({ nullable: true })
  bio?: string;

  @ManyToOne(() => Nation)
  @JoinColumn({ name: 'nation_id' })
  nation?: Nation;

  /*--------------------------------------------------
  | PREFERENCES                                      |
  --------------------------------------------------*/
  @Column({ length: 5, default: 'en' })
  language: string;

  @Column({ default: 'system' })
  theme: 'light' | 'dark' | 'system';

  /*--------------------------------------------------
  | AUTHORIZATION                                    |
  --------------------------------------------------*/
  @Column({
    type: 'enum',
    enum: UserRole,
    default: UserRole.USER,
  })
  role: UserRole;

  /*--------------------------------------------------
  | ACCOUNT STATUS                                   |
  --------------------------------------------------*/
  @Column({ name: 'email_verified', default: false })
  emailVerified: boolean;

  @Column({ name: 'is_active', default: true })
  isActive: boolean;

  @Column({ name: 'last_login_at', nullable: true })
  lastLoginAt?: Date;

  /*--------------------------------------------------
  | AUDIT                                            |
  --------------------------------------------------*/
  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;

  @UpdateDateColumn({ name: 'updated_at', nullable: true })
  updatedAt: Date;

  constructor(user: Partial<User>) {
    Object.assign(this, user);
  }
}
