import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/domain/auth/usecases/get_me_uc.dart';
import 'package:my_fm/presentation/home/bloc/user_display_state.dart';
import 'package:my_fm/service_locator.dart';

class UserDisplayCubit extends Cubit<UserDisplayState> {
  UserDisplayCubit() : super(UserLoading());

  void displayUser() async {
    var result = await sl<GetMeUserCase>().call();

    result.fold(
      (error) {
        emit(UserFailure(errorMessage: error));
      },
      (data) {
        emit(UserLoaded(userEntity: data));
      },
    );
  }
}
