import 'package:cars/cubits/search_cubit/search_cubit.dart';
import 'package:cars/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/main_cubit/main_cubit.dart';
import '../../cubits/main_cubit/main_states.dart';
import '../core/style/light.dart';
import '../cubits/auth_cubit/auth_cubit.dart';
import '../cubits/home_cubit/home_cubit.dart';
import '../cubits/setting_cubit/settings_cubit.dart';
import '../layout/splash/splash_screen.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => MainCubit()),
        BlocProvider(create: (BuildContext context) => AuthCubit()),
        BlocProvider(create: (BuildContext context) => SearchCubit()),
        BlocProvider(
            create: (BuildContext context) => HomeCubit()..getBanner()),
        BlocProvider(create: (BuildContext context) => SettingsCubit()),
      ],
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MainCubit.get(context);
          return ScreenUtilInit(
            designSize: const Size(360, 640),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (ctx, widget) => MaterialApp(
              debugShowCheckedModeBanner: false,
              builder: (context, widget) {
                ScreenUtil.init(context);
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                );
              },
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''),
                Locale('ar', ''),
              ],
              locale: Locale.fromSubtags(languageCode: cubit.language),
              theme: lightMode,
              themeMode: ThemeMode.light,
              home: const SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}
