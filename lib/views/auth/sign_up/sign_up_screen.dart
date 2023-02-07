import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/components/app_language.dart';
import '../../../core/components/default_buttons.dart';
import '../../../core/components/profile_picture.dart';
import '../../../core/components/text_form_field.dart';
import '../../../core/components/toast.dart';
import '../../../core/enums/image_type.dart';
import '../../../core/style/colors.dart';
import '../../../core/style/text_style.dart';
import '../../../cubits/auth_cubit/auth_cubit.dart';
import '../sign_in/login_screen.dart';

enum GenderType { male, female }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? nameController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? phoneController = TextEditingController();
  TextEditingController? photoController = TextEditingController();
  GenderType? _genderType;
  TextEditingController? statueController = TextEditingController();

  bool isLoading = false;
  AuthCubit? authCubit;
  @override
  void initState() {
    super.initState();
    authCubit = AuthCubit.get(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backGroundColor,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 9, 17, 75),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          centerTitle: true,
          title: Text(
            getLang(context).sign_up_text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
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
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return ProfilePicture(
                    imageType: ImageType.file,
                    imageLink: AuthCubit.get(context).photo,
                    onTap: () {
                      AuthCubit.get(context).pickImage();
                    },
                  );
                },
              ),
              SizedBox(height: 5.h),
              _buildForm(),
            ],
          ),
        ),
      ),
    );
  }

  _buildSignUpButton(context, state) {
    return state is UserRegisterLoadingState
        ? const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 9, 17, 75),
            ),
          )
        : DefaultButton(
            onPress: () {
              if (_key.currentState!.validate()) {
                AuthCubit.get(context).userRegister(
                  name: nameController!.text,
                  email: emailController!.text,
                  password: passwordController!.text,
                  phone: phoneController!.text,
                  gender: _genderType!.name.toString(),
                  // status: statueController!.text,
                  // photo: photoController!.text,
                );
              }
            },
            buttonText: getLang(context).sign_up_text,
            buttonWidth: MediaQuery.of(context).size.width * .4,
            buttonHeight: 40,
            buttonBorderCircular: 8,
          );
  }

  _buildForm() {
    return Column(
      children: [
        SizedBox(height: 15.h),
        Text(
          getLang(context).register,
          style: AppTextStyle.headLine(),
        ),
        SizedBox(height: 15.h),
        Text(
          getLang(context).sign_up_que,
          style: AppTextStyle.caption(),
        ),
        SizedBox(height: 15.h),
        DefaultTextField(
          labelText: getLang(context).user_name_text_field,
          controller: nameController,
          validator: (value) {
            if (value == null || value == "") {
              return getLang(context).email_validate;
            }
          },
        ),
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
        DefaultTextField(
          labelText: getLang(context).phone_text_field,
          controller: phoneController,
          // type: TextInputType.phone,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value == "") {
              return getLang(context).phone_validate;
            }
          },
        ),
        Row(
          children: [
            Expanded(
              child: RadioListTile<GenderType>(
                // contentPadding: EdgeInsets.all(0.0),
                value: GenderType.male,
                groupValue: _genderType,
                // dense: true,
                title: Text(GenderType.male.name),
                onChanged: (val) {
                  setState(() {
                    _genderType = val;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile<GenderType>(
                contentPadding: EdgeInsets.all(0.0),
                value: GenderType.female,
                groupValue: _genderType,
                title: Text(GenderType.female.name),
                onChanged: (val) {
                  setState(() {
                    _genderType = val;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is UserRegisterSuccessState) {
              toast(
                text: state.userRegisterModel.message!,
                color: Color.fromARGB(255, 9, 17, 75),
              );
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            } else if (state is UserRegisterErrorState) {
              toast(text: getLang(context).error_toast, color: Colors.red);
            }
          },
          builder: (context, state) {
            return _buildSignUpButton(context, state);
          },
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    authCubit!.clearData();
    super.dispose();
  }
}
