import { IsEmail, IsNotEmpty, IsString } from 'class-validator';
import { ErrorCode } from 'src/common/errors/error-codes';

export class LoginDto {
  @IsEmail({}, { message: ErrorCode.AUTH_INVALID_EMAIL })
  email: string;

  @IsNotEmpty({ message: ErrorCode.AUTH_EMPTY_PASSWORD })
  @IsString()
  password: string;
}
