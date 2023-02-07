import 'package:flutter/material.dart';

import '../../../core/style/colors.dart';

class DefaultAuthTextField extends StatelessWidget {
  DefaultAuthTextField(
      {super.key,
      this.labelText,
      this.controller,
      this.validator,
      this.obscureText,
      this.keyboardType});

  String? labelText;
  TextEditingController? controller;
  String? Function(String?)? validator;
  bool? obscureText;
  TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        filled: true,
        hintText: labelText,
        fillColor: AppColors.secondaryColor,
        focusColor: AppColors.secondaryColor,
      ),
    );
  }
}
