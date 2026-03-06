import { IsEmail, IsNotEmpty, Matches, MinLength } from 'class-validator';
import { ErrorCode } from 'src/common/constants/error-codes';

export class SignUpDto {
  @IsEmail({}, { message: ErrorCode.SIGN_EMAIL_INVALID })
  @IsNotEmpty({ message: ErrorCode.SIGN_EMAIL_EMPTY })
  email: string;

  @Matches(/[^A-Za-z0-9]/, { message: ErrorCode.SIGN_AUTH_PASSWORD_NO_SYMBOL })
  @Matches(/[A-Z]/, { message: ErrorCode.SIGN_AUTH_PASSWORD_NO_UPPERCASE })
  @Matches(/[a-z]/, { message: ErrorCode.SIGN_AUTH_PASSWORD_NO_LOWERCASE })
  @Matches(/\d/, { message: ErrorCode.SIGN_AUTH_PASSWORD_NO_NUMBER })
  @MinLength(6, { message: ErrorCode.SIGN_AUTH_PASSWORD_TOO_SHORT })
  @IsNotEmpty({ message: ErrorCode.SIGN_AUTH_PASSWORD_EMPTY })
  password: string;

  @MinLength(2, { message: ErrorCode.SIGN_AUTH_NAME_TOO_SHORT })
  @IsNotEmpty({ message: ErrorCode.SIGN_AUTH_NAME_EMPTY })
  name: string;
}
