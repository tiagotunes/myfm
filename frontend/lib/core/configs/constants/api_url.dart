class ApiUrl {
  static const baseUrl      = 'http://10.0.2.2:3000';

  static const authCtrl     = '/auth';
  static const getMe        = '$authCtrl/me';
  static const refreshToken = '$authCtrl/refresh-token';
  static const signIn       = '$authCtrl/sign-in';
  static const signOut      = '$authCtrl/sign-out';
  static const signUp       = '$authCtrl/sign-up';
}
