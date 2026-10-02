import { IsNotEmpty, IsString, Length } from 'class-validator';

export class CreateNationDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  denonym: string;

  @Length(2, 2)
  @IsString()
  @IsNotEmpty()
  cca2: string;

  @IsString()
  @IsNotEmpty()
  region: string;

  @IsString()
  @IsNotEmpty()
  subregion: string;
}
