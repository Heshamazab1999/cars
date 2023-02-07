import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCodeField extends StatelessWidget {
  CustomPinCodeField({Key? key, required this.pinCodeController})
      : super(key: key);
  final TextEditingController pinCodeController;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      animationType: AnimationType.fade,
      validator: (value) {
        if (value!.isEmpty) {
          return "Reset Code Password is Empty";
        }
        return null;
      },
      boxShadows: const [
        BoxShadow(
          color: Colors.grey,
          spreadRadius: 1,
          blurRadius: 7,
          offset: Offset(2, 3), // changes position of shadow
        ),
      ],
      keyboardType: TextInputType.number,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        selectedFillColor: Colors.white,
        activeColor: Colors.white,
        inactiveColor: Colors.white,
        inactiveFillColor: Colors.white,
        borderRadius: BorderRadius.circular(10),
        fieldHeight: 40.h,
        fieldWidth: 32.w,
        activeFillColor: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: pinCodeController,
      onCompleted: (v) {
        pinCodeController.text = v;
      },
      beforeTextPaste: (text) {
        return true;
      },
      appContext: context,
      onChanged: (String value) {},
    );
  }
}
