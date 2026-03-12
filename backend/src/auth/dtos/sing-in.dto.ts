import { IsEmail, IsNotEmpty } from 'class-validator';
import { ErrorCode } from 'src/common/constants/error-codes';

export class SignInDto {
  @IsEmail({}, { message: ErrorCode.SIGN_EMAIL_INVALID })
  @IsNotEmpty({ message: ErrorCode.SIGN_EMAIL_EMPTY })
  email: string;

  @IsNotEmpty({ message: ErrorCode.SIGN_PASSWORD_EMPTY })
  password: string;
}
