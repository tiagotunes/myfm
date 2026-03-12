import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/common/bloc/button/button_state.dart';
import 'package:my_fm/core/usecases/usecase.dart';

class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(ButtonInitialState());

  Future<void> execute({dynamic params, required UseCase usecase}) async {
    emit(ButtonLoadingState());

    try {
      Either result = await usecase.call(params: params);

      result.fold(
        (error) {
          emit(ButtonFailureState(errorMessage: error));
        },
        (_) {
          emit(ButtonSuccessState());
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(ButtonFailureState(errorMessage: e.toString()));
      }
    }
  }
}
