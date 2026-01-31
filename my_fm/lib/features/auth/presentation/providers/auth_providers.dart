import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_fm/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:my_fm/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:my_fm/features/auth/domain/usecases/login_usecase.dart';
import 'package:my_fm/features/auth/presentation/providers/auth_notifier.dart';
import 'package:my_fm/features/auth/presentation/providers/auth_state.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: 'https://api.yourbackend.com'));
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((
  ref,
) {
  final dio = ref.read(dioProvider);
  final remoteDataSource = AuthRemoteDataSource(dio);
  final repository = AuthRepositoryImpl(remoteDataSource);
  final loginUseCase = LoginUseCase(repository);

  return AuthNotifier(loginUseCase);
});
