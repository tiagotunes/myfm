import 'package:dartz/dartz.dart';
import 'package:my_fm/core/usecases/usecase.dart';
import 'package:my_fm/data/auth/models/sign_in_request.dart';
import 'package:my_fm/domain/auth/repositories/auth_rep.dart';
import 'package:my_fm/service_locator.dart';

class SignInUseCase extends UseCase<Either, SignInRequest> {
  @override
  Future<Either<dynamic, dynamic>> call(SignInRequest? params) async {
    return await sl<AuthRepository>().signIn(params!);
  }
}
