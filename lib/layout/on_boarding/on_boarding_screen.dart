import 'package:cars/core/components/app_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../views/auth/sign_in/login_screen.dart';
import 'intro_screens/intro_screen_1.dart';
import 'intro_screens/intro_screen_2.dart';
import 'intro_screens/intro_screen_3.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: [
            IntroScreen1(),
            IntroScreen2(),
            IntroScreen3(),
          ],
        ),
        Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                    child: Text(getLang(context).skip)),
                SmoothPageIndicator(controller: _controller, count: 3),
                onLastPage
                    ? GestureDetector(
                        onTap: (() {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        }),
                        child: Text(getLang(context).done))
                    : GestureDetector(
                        onTap: (() {
                          _controller.nextPage(
                              duration: Duration(
                                milliseconds: 500,
                              ),
                              curve: Curves.easeIn);
                        }),
                        child: Text(getLang(context).next)),
              ],
            )),
      ],
    ));
  }
}
