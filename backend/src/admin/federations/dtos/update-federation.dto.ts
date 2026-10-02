import { IsBoolean, IsOptional, IsString } from 'class-validator';

export class UpdateFederationDto {
  @IsOptional()
  @IsString()
  acronym: string;

  @IsOptional()
  @IsString()
  name: string;

  @IsOptional()
  @IsBoolean()
  isActive: string;
}
