import { Controller, Get, UseGuards } from '@nestjs/common';
import { RolesGuard } from '@/auth/guards/roles.guard';
import { Roles } from '@/common/decorators/roles.decorator';
import { UserRole } from '@/users/user.entity';
import { ContinentService } from '@/admin/continents/continent.service';

@Controller('continents')
@UseGuards(RolesGuard)
@Roles(UserRole.ADMIN)
export class ContinentController {
  constructor(private readonly continentService: ContinentService) {}

  @Get()
  getAll() {
    return this.continentService.getAll();
  }

  @Get('/count')
  getCount() {
    return this.continentService.getCount();
  }
}
