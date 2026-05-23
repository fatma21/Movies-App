import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../features/explore/data/data_source/explore_local_data_source.dart';
import '../../features/explore/data/data_source/explore_remote_data_source.dart';
import '../../features/explore/data/repositories/explore_repo.dart';
import '../../features/explore/presentation/mangers/explore_cubit.dart';
import '../../features/profile/data/data_sources/profile_local_data_source.dart';
import '../../features/search/data/data_source/search_repo.dart';
import '../../features/search/data/search_remote_date_source.dart';
import '../../features/search/presentation/managers/search_cubit.dart';
import '../network/api_service.dart';
import '../../features/home/data/data_source/home_remote_data_source.dart';
import '../../features/home/data/repositories/home_repo.dart';
import '../../features/home/presentation/managers/home_cubit.dart';
import '../../features/profile/data/data_sources/profile_remote_data_source.dart';
import '../../features/profile/data/repositories/profile_repo.dart';
import '../../features/profile/presentation/managers/profile_cubit.dart';
import '../../features/home/data/data_source/home_local_data_source.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Core
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => ApiService(sl()));

  // Home
  sl.registerLazySingleton(() => HomeRemoteDataSource(sl()));
  sl.registerLazySingleton(() => HomeLocalDataSource());
  sl.registerLazySingleton(
        () => HomeRepo(
      sl<HomeRemoteDataSource>(),
      sl<HomeLocalDataSource>(),
    ),
  );  sl.registerFactory(() => HomeCubit(sl()));

  // Profile
  sl.registerLazySingleton(() => ProfileRemoteDataSource());
  sl.registerLazySingleton(() => ProfileLocalDataSource());
  sl.registerLazySingleton(() => ProfileRepo(sl<ProfileRemoteDataSource>(),sl<ProfileLocalDataSource>()));
  sl.registerFactory(() => ProfileCubit(sl()));
  sl.registerLazySingleton(() => ExploreRemoteDataSource(sl()));
  sl.registerLazySingleton(() => ExploreLocalDataSource(
    Hive.box<List>('exploreBox'),
  ),);
  sl.registerLazySingleton(() => ExploreRepo(sl<ExploreRemoteDataSource>(), sl<ExploreLocalDataSource>()));
  sl.registerFactory(() => ExploreCubit(sl()));
  sl.registerLazySingleton(() => SearchRemoteDataSource(sl()));
  sl.registerLazySingleton(() => SearchRepo(sl()));
  sl.registerFactory(() =>  SearchCubit(sl()));
}