import 'package:flutter/material.dart';

class CustomTextSignUp extends StatelessWidget {
  final String textone;
  final String texttwo;
  final void Function() onTap;
  const CustomTextSignUp(
      {Key? key,
      required this.textone,
      required this.texttwo,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(textone),
        InkWell(
          onTap: onTap,
          child: Text(texttwo,
              style: const TextStyle(
                  color: Color.fromARGB(255, 9, 17, 75),
                  fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}
