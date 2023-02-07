import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../views/auth/components/text_form_field.dart';
import '../style/text_style.dart';

class DefaultTextField extends StatelessWidget {
  DefaultTextField({
    super.key,
    this.labelText,
    this.controller,
    this.validator,
    this.obscureText,
    this.keyboardType,
  });

  String? labelText;
  TextEditingController? controller;
  String? Function(String?)? validator;
  bool? obscureText;
  TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    // return SizedBox(
    //   width: width ?? double.infinity,
    //   child: TextFormField(
    //     onChanged: onChanged,
    //     validator: validator,
    //     keyboardType: keyboardType,
    //     style: style,
    //     obscureText: obscureText ?? false,
    //     decoration: InputDecoration(
    //         labelText: labelText,
    //         labelStyle: AppTextStyle.caption(),
    //         suffixIcon: icon ?? Container(),
    //         enabledBorder: const UnderlineInputBorder(
    //           borderSide: BorderSide(color: Colors.black),
    //         ),
    //         focusedBorder: const UnderlineInputBorder(
    //           borderSide: BorderSide(color: AppColors.primaryColor),
    //         ),
    //         border: const UnderlineInputBorder(
    //             borderSide: BorderSide(color: AppColors.primaryColor)),
    //         contentPadding: const EdgeInsets.all(10)),
    //     minLines: lines ?? 1,
    //     maxLines: lines ?? 1,
    //     controller: controller,
    //   ),
    // );
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText!,
            style: AppTextStyle.caption().copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.h,
          ),
          DefaultAuthTextField(
            controller: controller,
            labelText: labelText,
            obscureText: obscureText,
            validator: validator,
            keyboardType: keyboardType,
          )
        ],
      ),
    );
  }
}
