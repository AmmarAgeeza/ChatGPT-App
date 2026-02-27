import 'package:chatgpt_app/core/database/cache/cache_helper.dart';
import 'package:chatgpt_app/features/home/data/repos/home_repo.dart';
import 'package:chatgpt_app/features/home/views/cubit/chat_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../features/chat/data/repos/chat_repo.dart';
import '../../features/chat/data/repos/chat_repo_impl.dart';
import '../../features/chat/data/services/gemini_chat_service.dart';
import '../../features/chat/ui/cubit/ai_chat_cubit.dart';
import '../database/api/api_consumer.dart';
import '../database/api/app_interceptors.dart';
import '../database/api/dio_consumer.dart';
import '../network/netwok_info.dart';

final sl = GetIt.instance;
Future<void> serviceLocatorInit() async {
  await CacheHelper.init();
  //cubits
  sl.registerFactory(() => ChatCubit(sl()));
  sl.registerFactory(() => AiChatCubit(chatRepo: sl()));
  //repo
  sl.registerLazySingleton(() => HomeRepo());
  sl.registerLazySingleton<ChatRepo>(
    () => ChatRepoImpl(geminiChatService: sl()),
  );
  sl.registerLazySingleton(() => GeminiChatService());
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
