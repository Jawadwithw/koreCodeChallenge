import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:korecotask/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:korecotask/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:korecotask/features/auth/domain/repositories/auth_repository.dart';
import 'package:korecotask/features/auth/domain/usecases/login_usecase.dart';
import 'package:korecotask/features/auth/presentation/blocs/login_bloc/login_bloc.dart';

import 'data/network/network_info.dart';

final sl = GetIt.instance;
Future<void> initDependencies() async {
  // Core
  initExternal();
  //Auth
  initAuth();
}

void initAuth() {
  //blocs
  sl.registerFactory(() => LoginBloc(loginUsecase: sl()));
  //usecases
  sl.registerLazySingleton(() => LoginUsecase(repository: sl()));
  //remote datasource
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(dio: sl()),
  );
  //repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDatasource: sl(), networkInfo: sl()),
  );
}

void initExternal() {
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
