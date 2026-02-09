import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  UpdateDateColumn,
  Index,
} from 'typeorm';

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
  @Column({ length: 255 })
  email: string;

  @Column({ name: 'password_hash', length: 255 })
  passwordHash: string;

  /*--------------------------------------------------
  | PROFILE                                          |
  --------------------------------------------------*/
  @Column({ name: 'display_name', length: 50 })
  displayName: string;

  @Column({ length: 160, nullable: true })
  bio?: string;

  @Column({ name: 'country_code', length: 2, nullable: true })
  countryCode?: string;

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

  @UpdateDateColumn({ name: 'updated_at' })
  updatedAt: Date;
}
