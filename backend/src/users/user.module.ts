import { Module } from '@nestjs/common';
import { UserService } from '@/users/user.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from '@/users/user.entity';

@Module({
  imports: [TypeOrmModule.forFeature([User])],
  providers: [UserService],
  exports: [UserService],
})
export class UserModule {}
