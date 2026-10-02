import { ErrorCode } from '@/common/constants/error-codes';
import { IsNotEmpty } from 'class-validator';

export class CreateFederationDto {
  @IsNotEmpty({ message: ErrorCode.FEDERATION_ACRONYM_EMPTY })
  acronym: string;

  @IsNotEmpty({ message: ErrorCode.FEDERATION_NAME_EMPTY })
  name: string;
}
