import { Controller, Get, UseGuards } from '@nestjs/common';
import { RolesGuard } from '@/auth/guards/roles.guard';
import { Roles } from '@/common/decorators/roles.decorator';
import { UserRole } from '@/users/user.entity';
import { NationService } from '@/admin/nations/nation.service';

@Controller('nations')
@UseGuards(RolesGuard)
@Roles(UserRole.ADMIN)
export class NationController {
  constructor(private readonly nationService: NationService) {}

  @Get()
  getAll() {
    return this.nationService.getAll();
  }

  @Get('/count')
  getCount() {
    return this.nationService.getCount();
  }
}
