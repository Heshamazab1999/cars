import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/components/app_language.dart';
import '../../../core/components/toast.dart';
import '../../../cubits/auth_cubit/auth_cubit.dart';
import '../change_password/change_password_screen.dart';
import '../change_password/components/cusotm_form.dart';
import '../change_password/components/custom_button.dart';
import '../change_password/components/custom_text.dart';
import '../change_password/components/custom_title.dart';
import '../sign_in/login_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UserForgetPasswordSuccessState) {
          toast(
            text: state.message,
            color: Color.fromARGB(255, 9, 17, 75),
          );
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangePasswordScreen(
                        email: emailController.text,
                      )));
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (context) => const MainLayout()),
          //         (route) => false);
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 9, 17, 75),
            title: Text(getLang(context).forget_pass_text),
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0.w),
            child: Column(
              children: [
                SizedBox(height: 50.h),
                // const Logo(),
                SizedBox(height: 30.h),
                CustomTitle(text: getLang(context).reset_pass_text),
                SizedBox(height: 30.h),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomForm(
                        hintText: getLang(context).enter_email_text_field,
                        iconData: Icons.email_outlined,
                        labelText: getLang(context).email_text_field,
                        controller: emailController,
                        type: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                ),
                state is UserForgetPasswordLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomButton(
                        text: getLang(context).code_msg,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.sendCodeToEmail(
                              email: emailController.text,
                            );
                          }
                        }),
                const SizedBox(height: 40),
                CustomTextSignUp(
                  textone: getLang(context).have_acc_que,
                  texttwo: getLang(context).login_butt_login,
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
