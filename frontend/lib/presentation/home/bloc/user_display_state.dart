import 'package:my_fm/domain/auth/entities/user_entity.dart';

abstract class UserDisplayState {}

class UserLoading extends UserDisplayState {}

class UserLoaded extends UserDisplayState {
  final UserEntity userEntity;
  UserLoaded({required this.userEntity});
}

class UserFailure extends UserDisplayState {
  final String errorMessage;
  UserFailure({required this.errorMessage});
}
