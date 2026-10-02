import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  HttpStatus,
  Param,
  Post,
  UseGuards,
} from '@nestjs/common';
import { FederationService } from '@/admin/federations/federation.service';
import { RolesGuard } from '@/auth/guards/roles.guard';
import { Roles } from '@/common/decorators/roles.decorator';
import { UserRole } from '@/users/user.entity';
import { CreateFederationDto } from '@/admin/federations/dtos/create-federation.dto';
import { UpdateFederationDto } from '@/admin/federations/dtos/update-federation.dto';

@Controller('federations')
@UseGuards(RolesGuard)
@Roles(UserRole.ADMIN)
export class FederationController {
  constructor(private readonly federationService: FederationService) {}

  @Get()
  getAll() {
    return this.federationService.getAll();
  }

  @Get('/count')
  getCount() {
    return this.federationService.getCount();
  }

  @Get(':id')
  get(@Param('id') id: string) {
    return this.federationService.getById(id);
  }

  @Post()
  @HttpCode(HttpStatus.CREATED)
  create(@Body() body: CreateFederationDto) {
    return this.federationService.create(body);
  }

  @Post(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  update(@Param('id') id: string, @Body() body: UpdateFederationDto) {
    return this.federationService.update(id, body);
  }

  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  delete(@Param('id') id: string) {
    return this.federationService.delete(id);
  }
}
