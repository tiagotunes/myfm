import 'package:dartz/dartz.dart';
import 'package:my_fm/core/usecases/usecase.dart';
import 'package:my_fm/domain/auth/repositories/auth_rep.dart';
import 'package:my_fm/service_locator.dart';

class GetMeUserCase extends UseCase<Either, void> {
  @override
  Future<Either> call({params}) async {
    return await sl<AuthRepository>().getMe();
  }
}
