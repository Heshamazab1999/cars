import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cars/core/utils/navigation_utils.dart';
import 'package:cars/models/user_profile_model/user_profile_model.dart';
import 'package:cars/views/auth/sign_in/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/login_model/login_model.dart';
import '../../models/register_model/register_model.dart';
import '../../repositories/local/cache_helper.dart';
import '../../repositories/local/cache_keys.dart';
import '../../repositories/remote/dio_helper.dart';
import '../../repositories/remote/end_points.dart';
import 'package:file_picker/file_picker.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  RegisterModel? userRegisterModel;
  LoginModel? userLoginModel;
  File? photo;
  void pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result == null) return;
    photo = File(result.files.single.path!);
    emit(SuccessPickImageState());
  }

  void clearData() {
    photo = null;
    emit(ClearDataState());
  }

  userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String gender,
  }) async {
    emit(UserRegisterLoadingState());
    await DioHelper.postForm(
        url: REGISTER,
        data: FormData.fromMap({
          "name": name,
          "email": email,
          "password": password,
          "phone": phone,
          "gender": gender,
          if (photo != null) "photo": await MultipartFile.fromFile(photo!.path),
        })).then((value) {
      if (value.statusCode == 200) {
        userRegisterModel = RegisterModel.fromJson(value.data);
        emit(UserRegisterSuccessState(userRegisterModel!));
      } else {
        debugPrint(value.data.toString());
        emit(UserRegisterErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(UserRegisterErrorState());
    });
  }
  //--------------------------------------------------------------Register

  userLogin({
    required String email,
    required String password,
  }) {
    emit(UserLoginLoadingState());
    DioHelper.postForm(
        url: LOGIN,
        data: FormData.fromMap({
          "email": email,
          "password": password,
        })).then((value) {
      if (value.statusCode == 200) {
        userLoginModel = LoginModel.fromJson(value.data);
        emit(UserLoginSuccessState(userLoginModel!));
      } else {
        debugPrint(value.data.toString());
        emit(UserLoginErrorState(value.data["message"]));
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(UserLoginErrorState("error"));
    });
  }

  //--------------------------------------------------------login
  sendCodeToEmail({
    required String email,
  }) {
    emit(UserForgetPasswordLoadingState());
    DioHelper.postData(url: FORGETPASSWORD, data: {
      "email": email,
    }).then((value) {
      emit(UserForgetPasswordSuccessState(value.data["message"].toString()));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(UserForgetPasswordErrorState());
    });
  }

//---------------------------------------------send code
  changePassword({
    required String code,
    required String password,
    required String confirmPassword,
  }) {
    emit(ChangePasswordLoadingState());
    DioHelper.postData(url: CHECKCODE, data: {
      "code": code,
      "password": password,
      "password_confirmation": confirmPassword,
    }).then((value) {
      emit(ChangePasswordSuccessState(value.data["message"].toString()));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ChangePasswordErrorState());
    });
  }

//----------------------------------------- change password
  userLogout(BuildContext context) async {
    emit(UserLogoutLoadingState());
    await DioHelper.postDataWithToken(url: LOGOUT, data: {
      // "userToken": CacheKeysManger.getUserTokenFromCache(),
    }).then((value) {
      if (value.statusCode == 200) {
        CacheHelper.saveData(key: "userToken", value: "NO");
        CacheHelper.saveData(key: "isLogin", value: false);
        emit(UserLogoutSuccessState(value.data["message"]));
        NavigationUtils.navigateAndClearStack(
            context: context, destinationScreen: const LoginScreen());
      } else {
        debugPrint(value.data.toString());
        emit(UserLogoutErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(UserLogoutErrorState());
    });
  }

  //-------------------------------------------------logout
  String? language = CacheHelper.getData(key: "language") ?? "ar";
  changeLanguage(String? lang) {
    language = lang;
    CacheHelper.saveData(key: "language", value: language);
    emit(ChangeLanguageState());
  }

  //----------------------------------------------- language
  updateProfile({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(UpdateLoadingState());
    await DioHelper.postFormWithToken(
        url: EDITPROFILE,
        data: FormData.fromMap({
          "name": name,
          "email": email,
          "phone": phone,
          if (photo != null) "photo": await MultipartFile.fromFile(photo!.path),
        })).then((value) {
      if (value.statusCode == 200) {
        userProfileModel!.data!.name = name;
        userProfileModel!.data!.email = email;
        userProfileModel!.data!.phone = phone;

        userProfileModel!.data!.photo =
            photo != null ? photo!.path : userProfileModel!.data!.photo;

        emit(UpdateSuccessState(value.data['message']));
      } else {
        debugPrint(value.data.toString());
        emit(UpdateErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(UpdateErrorState());
    });
  }
  //------------------------------------------------update profile

  UserProfileModel? userProfileModel;
  getProfile() async {
    emit(GetProfileLoadingState());
    await DioHelper.getDataWithToken(url: GET_PROFILE).then((value) {
      if (value.statusCode == 200) {
        userProfileModel = UserProfileModel.fromJson(value.data);
        emit(GetProfileSuccessState());
      } else {
        debugPrint(value.data.toString());
        emit(GetProfileErrorState("error"));
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetProfileErrorState("error"));
    });
  }
}
