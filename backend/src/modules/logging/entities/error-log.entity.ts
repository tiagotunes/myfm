import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  Index,
} from 'typeorm';

export enum HttpMethod {
  GET = 'GET',
  POST = 'POST',
  PUT = 'PUT',
  PATCH = 'PATCH',
  DELETE = 'DELETE',
}

@Entity('error_logs')
export class ErrorLog {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Index()
  @Column()
  source: string;

  @Column({ type: 'enum', enum: HttpMethod })
  method: HttpMethod;

  @Column()
  path: string;

  @Index()
  @Column()
  status: number;

  @Column({ name: 'error_message' })
  errorMessage: string;

  @Column({ nullable: true })
  stack?: string;

  @Column({ name: 'request_body', type: 'jsonb', nullable: true })
  requestBody?: Record<string, any>;

  @Column({ name: 'request_params', type: 'jsonb', nullable: true })
  requestParams?: Record<string, any>;

  @Column({ name: 'user_id', nullable: true })
  userId?: string;

  @Column({ name: 'ip_address', nullable: true })
  ipAddress?: string;

  @Column({ name: 'user_agent', nullable: true })
  userAgent?: string;

  @Index()
  @CreateDateColumn({ name: 'created_at', default: () => 'CURRENT_TIMESTAMP' })
  createdAt: Date;
}
