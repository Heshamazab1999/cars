import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/components/app_language.dart';
import '../../../core/components/default_buttons.dart';
import '../../../core/components/text_form_field.dart';
import '../../../core/style/colors.dart';
import '../../../core/style/text_style.dart';
import '../../../core/utils/navigation_utils.dart';
import '../../../cubits/auth_cubit/auth_cubit.dart';
import '../../../repositories/local/cache_helper.dart';
import '../../home/home_screen.dart';
import '../../settings/settings_screen/settings_screen.dart';
import '../forget_password/forget_password_screen.dart';
import '../sign_up/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backGroundColor,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 9, 17, 75),
          leading: IconButton(
              onPressed: () {
                NavigationUtils.navigateTo(
                    context: context, destinationScreen: SettingScreen());
              },
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              )),
        ),
        body: _buildBody(),
      ),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: _key,
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Image.asset(
                "assets/person-using-tablet.jpg",
                width: 150.w,
                height: MediaQuery.of(context).size.height * .15,
              ),
              SizedBox(height: 5.h),
              _buildForm(),
            ],
          ),
        ),
      ),
    );
  }

  _buildLoginButton() {
    return BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
      return state is UserLoginLoadingState
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 9, 17, 75),
              ),
            )
          : DefaultButton(
              onPress: () {
                if (_key.currentState!.validate()) {
                  AuthCubit.get(context).userLogin(
                      email: emailController!.text.toString(),
                      password: passwordController!.text.toString());
                } else {
                  FToast fToast = FToast();
                  fToast.init(context);
                  fToast.showToast(
                      child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 9, 17, 75),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    width: 100,
                    height: 50,
                    child: Text(
                      getLang(context).error_toast,
                      style: AppTextStyle.bodyText(),
                    ),
                  ));
                }
              },
              buttonText: getLang(context).login_butt_login,
              buttonWidth: MediaQuery.of(context).size.width * .4,
              buttonHeight: 40,
              buttonBorderCircular: 8,
            );
    }, listener: (context, state) {
      if (state is UserLoginSuccessState) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Login Success"),
          backgroundColor: Color.fromARGB(255, 9, 17, 75),
        ));
        CacheHelper.saveData(key: "isLogin", value: true).then((value) {
          CacheHelper.saveData(
                  key: "userToken", value: state.userLoginModel.accessToken)
              .then((value) {
            NavigationUtils.navigateAndClearStack(
                context: context, destinationScreen: HomeScreen());
          });
        });
      } else if (state is UserLoginErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.message),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  _buildForm() {
    return Column(
      children: [
        SizedBox(height: 15.h),
        Text(
          getLang(context).login_butt_login,
          style: AppTextStyle.headLine(),
        ),
        SizedBox(height: 15.h),
        Text(
          getLang(context).login_question,
          style: AppTextStyle.caption(),
        ),
        SizedBox(height: 15.h),
        DefaultTextField(
          labelText: getLang(context).email_text_field,
          controller: emailController,
          validator: (value) {
            if (value == null || value == "") {
              return getLang(context).email_validate;
            }
          },
        ),
        DefaultTextField(
          labelText: getLang(context).password_text_field,
          obscureText: true,
          controller: passwordController,
          validator: (value) {
            if (value == null || value == "") {
              return getLang(context).password_validate;
            }
          },
        ),
        Container(
            width: double.infinity,
            margin: EdgeInsets.only(
                right: getLang(context).localeName == "en" ? 25 : 0,
                left: getLang(context).localeName == "en" ? 0 : 25),
            alignment: getLang(context).localeName == "en"
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: GestureDetector(
              onTap: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgetPasswordScreen(),
                    ));
              }),
              child: Text(
                getLang(context).forget_password_text,
                style: AppTextStyle.caption().copyWith(
                  color: Color.fromARGB(255, 9, 17, 75),
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        SizedBox(height: 25.h),
        _buildLoginButton(),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(getLang(context).dont_have_acc_text),
            GestureDetector(
              onTap: () {
                NavigationUtils.navigateTo(
                    context: context, destinationScreen: const SignUpScreen());
              },
              child: Text(
                getLang(context).sign_up_text,
                style: AppTextStyle.caption().copyWith(
                  color: Color.fromARGB(255, 9, 17, 75),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
