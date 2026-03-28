class SignUpParams {
  final String email;
  final String password;
  final String confirmPassword;
  final String name;

  SignUpParams({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'name': name,
    };
  }
}
