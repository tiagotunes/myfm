import {
  Controller,
  Post,
  Body,
  HttpCode,
  HttpStatus,
  Get,
  Request,
  UseGuards,
} from '@nestjs/common';
import { AuthService } from '@/auth/auth.service';
import { SignInDto } from '@/auth/dtos/sing-in.dto';
import { SignUpDto } from '@/auth/dtos/sign-up.dto';
import { Public } from '@/common/decorators/public.decorator';
import { RefreshTokenGuard } from '@/auth/auth.guard';
import { UsersService } from '@/users/users.service';

@Controller('auth')
export class AuthController {
  constructor(
    private readonly authService: AuthService,
    private readonly usersService: UsersService,
  ) {}

  @Get('me')
  getProfile(@Request() req: any) {
    return this.usersService.getInfo(req.user.id);
  }

  @Public()
  @UseGuards(RefreshTokenGuard)
  @Post('refresh-token')
  refreshToken(@Request() req: any) {
    return this.authService.refreshToken(req.user);
  }

  @Public()
  @Post('sign-in')
  @HttpCode(HttpStatus.OK)
  signIn(@Body() body: SignInDto) {
    return this.authService.signIn(body);
  }

  @Post('sign-out')
  @HttpCode(HttpStatus.NO_CONTENT)
  signOut(@Request() req: any) {
    return this.authService.signOut(req.user);
  }

  @Public()
  @Post('sign-up')
  signUp(@Body() body: SignUpDto) {
    return this.authService.signUp(body);
  }
}
