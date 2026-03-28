import 'package:dartz/dartz.dart';
import 'package:my_fm/core/usecases/usecase.dart';
import 'package:my_fm/data/auth/models/sign_up_params.dart';
import 'package:my_fm/domain/auth/repositories/auth_rep.dart';
import 'package:my_fm/service_locator.dart';

class SignUpUseCase extends UseCase<Either, SignUpParams> {
  @override
  Future<Either> call({SignUpParams? params}) async {
    return await sl<AuthRepository>().signUp(params!);
  }
}