import 'package:get_it/get_it.dart';
import 'package:my_fm/common/bloc/auth/auth_cubit.dart';
import 'package:my_fm/core/network/dio_cliente.dart';
import 'package:my_fm/data/auth/repositories/auth_rep_impl.dart';
import 'package:my_fm/data/auth/sources/auth_api_service.dart';
import 'package:my_fm/data/auth/storage/token_storage.dart';
import 'package:my_fm/data/dashboard/repositories/dashboard_rep_impl.dart';
import 'package:my_fm/data/dashboard/sources/dashboard_api_service.dart';
import 'package:my_fm/domain/auth/repositories/auth_rep.dart';
import 'package:my_fm/domain/auth/usecases/get_me_uc.dart';
import 'package:my_fm/domain/auth/usecases/refresh_token_uc.dart';
import 'package:my_fm/domain/auth/usecases/sign_in_uc.dart';
import 'package:my_fm/domain/auth/usecases/sign_out_uc.dart';
import 'package:my_fm/domain/auth/usecases/sign_up_uc.dart';
import 'package:my_fm/domain/dashboard/repositories/dashboard_rep.dart';
import 'package:my_fm/domain/dashboard/usecases/get_configuration_count_uc.dart';
import 'package:my_fm/domain/dashboard/usecases/get_configurations_uc.dart';
import 'package:my_fm/domain/dashboard/usecases/post_configuration_uc.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<TokenStorage>(TokenStorage());
  sl.registerSingleton<DioClient>(DioClient());

  // Services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<DashboardApiService>(DashboardApiServiceImpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<DashboardRepository>(DashboardRepositoryImpl());

  // Usecases
  sl.registerSingleton<GetMeUserCase>(GetMeUserCase());
  sl.registerSingleton<RefreshTokenUseCase>(RefreshTokenUseCase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<SignOutUseCase>(SignOutUseCase());
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<GetConfigurationCountUserCase>(GetConfigurationCountUserCase());
  sl.registerSingleton<GetConfigurationsUseCase>(GetConfigurationsUseCase());
  sl.registerSingleton<PostConfigurationUseCase>(PostConfigurationUseCase());

  // Cubits
  sl.registerLazySingleton<AuthCubit>(() => AuthCubit());
}
