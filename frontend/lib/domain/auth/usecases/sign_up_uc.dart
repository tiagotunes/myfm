import 'package:dartz/dartz.dart';
import 'package:my_fm/core/usecases/usecase.dart';
import 'package:my_fm/data/auth/models/sign_up_request.dart';
import 'package:my_fm/domain/auth/repositories/auth_rep.dart';
import 'package:my_fm/service_locator.dart';

class SignUpUseCase extends UseCase<Either, SignUpRequest> {
  @override
  Future<Either> call({SignUpRequest? params}) async {
    return await sl<AuthRepository>().signUp(params!);
  }
}