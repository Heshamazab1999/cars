import 'package:flutter/cupertino.dart';

class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/image.png"),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                Text(
                    "The first working steam-powered vehicle was designed by Ferdinand Verbiest, a Flemish member of a Jesuit mission in China around 1672"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
