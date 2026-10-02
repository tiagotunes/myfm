abstract class AuthState {}

class AppInitialState extends AuthState {}

class AuthenticatedState extends AuthState {
  final bool isAdmin;
  AuthenticatedState(this.isAdmin);
}

class UnauthenticatedState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;
  AuthErrorState(this.message);
}
