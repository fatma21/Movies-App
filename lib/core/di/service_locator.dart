import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../network/api_service.dart';
import '../../features/home/data/data_source/home_remote_data_source.dart';
import '../../features/home/data/repositories/home_repo.dart';
import '../../features/home/presentation/managers/home_cubit.dart';
import '../../features/profile/data/data_sources/profile_remote_data_source.dart';
import '../../features/profile/data/repositories/profile_repo.dart';
import '../../features/profile/presentation/managers/profile_cubit.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Core
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => ApiService(sl()));

  // Home
  sl.registerLazySingleton(() => HomeRemoteDataSource(sl()));
  sl.registerLazySingleton(() => HomeRepo(sl()));
  sl.registerFactory(() => HomeCubit(sl()));

  // Profile
  sl.registerLazySingleton(() => ProfileRemoteDataSource());
  sl.registerLazySingleton(() => ProfileRepo(sl()));
  sl.registerFactory(() => ProfileCubit(sl()));
}