import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../cubits/my_bloc_observer.dart';
import 'repositories/local/cache_helper.dart';
import 'repositories/remote/dio_helper.dart';
import 'src/app_root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  Bloc.observer = MyBlocObserver();

  runApp(const AppRoot());
}
