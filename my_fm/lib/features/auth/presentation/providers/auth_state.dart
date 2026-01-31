class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? errorMessage;

  const AuthState({
    required this.isLoading,
    required this.isAuthenticated,
    this.errorMessage,
  });

  factory AuthState.initial() {
    return const AuthState(isLoading: false, isAuthenticated: false);
  }

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? errorMessage,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      errorMessage: errorMessage,
    );
  }
}
