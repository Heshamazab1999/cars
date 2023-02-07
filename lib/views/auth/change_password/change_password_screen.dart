import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/components/app_language.dart';
import '../../../core/components/toast.dart';
import '../../../cubits/auth_cubit/auth_cubit.dart';
import '../sign_in/login_screen.dart';
import 'components/cusotm_form.dart';
import 'components/custom_button.dart';
import 'components/custom_pin_code_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;
  var pinCodeController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessState) {
          toast(
            text: state.message,
            color: Color.fromARGB(255, 9, 17, 75),
          );
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false);
        } else if (state is ChangePasswordErrorState) {
          toast(text: getLang(context).error_toast, color: Colors.red);
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0.0,
            actions: [
              TextButton(
                onPressed: () {
                  cubit.sendCodeToEmail(email: email);
                },
                child: Text(
                  getLang(context).resend_code_text,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 9, 17, 75),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const Logo(),
                    SizedBox(height: 30.h),
                    Text(
                      getLang(context).reset_pass_text,
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        getLang(context).reset_code,
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomPinCodeField(
                      pinCodeController: pinCodeController,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomForm(
                      hintText: getLang(context).enter_pass_hint_text,
                      iconData: Icons.lock_outline,
                      labelText: getLang(context).password_text_field,
                      isPassword: true,
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                    ),
                    CustomForm(
                      hintText: getLang(context).confirm_pass_hint_text,
                      iconData: Icons.lock_outline,
                      labelText: getLang(context).confirm_pass_label_text,
                      isPassword: true,
                      controller: confirmPasswordController,
                      type: TextInputType.visiblePassword,
                    ),
                    state is ChangePasswordLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            text: getLang(context).reset_pass_text,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (passwordController.text ==
                                    confirmPasswordController.text) {
                                  cubit.changePassword(
                                    code: pinCodeController.text,
                                    password: passwordController.text,
                                    confirmPassword:
                                        confirmPasswordController.text,
                                  );
                                } else {
                                  toast(
                                      text: getLang(context).reset_pass_toast,
                                      color: Colors.red);
                                }
                              }
                            }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
