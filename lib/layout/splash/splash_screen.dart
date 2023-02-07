import 'package:cars/repositories/local/cache_helper.dart';
import 'package:cars/repositories/local/cache_keys.dart';
import 'package:cars/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/style/colors.dart';
import '../../core/utils/navigation_utils.dart';
import '../on_boarding/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (CacheHelper.getData(key: "isLogin") != null) {
        if (CacheHelper.getData(key: "isLogin")) {
          NavigationUtils.navigateAndClearStack(
              context: context, destinationScreen: const HomeScreen());
        } else {
          NavigationUtils.navigateAndClearStack(
              context: context, destinationScreen: const OnBoardingScreen());
        }
      } else {
        NavigationUtils.navigateAndClearStack(
            context: context, destinationScreen: const OnBoardingScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            "assets/lexus2.png",
            width: 300.w,
            height: 450.h,
          ),
          const CircularProgressIndicator(
            color: AppColors.primaryColor,
          )
        ],
      ),
    );
  }
}
