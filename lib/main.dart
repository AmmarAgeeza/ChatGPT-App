import 'package:chatgpt_app/app/app.dart';
import 'package:chatgpt_app/core/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/bloc/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );
  Bloc.observer = MyBlocObserver();
  await serviceLocatorInit();
  runApp(const MyApp());
}
