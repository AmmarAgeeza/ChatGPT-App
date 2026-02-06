import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../database/api/api_consumer.dart';
import '../database/api/app_interceptors.dart';
import '../database/api/dio_consumer.dart';
import '../network/netwok_info.dart';

final sl = GetIt.instance;
Future<void> serviceLocatorInit() async {
  //External
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );
  sl.registerLazySingleton(() => Dio());

  sl.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(client: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton(
    () => LogInterceptor(
      responseBody: true,
      error: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
      requestBody: true,
    ),
  );
  sl.registerLazySingleton(() => AppIntercepters(client: sl()));
}
