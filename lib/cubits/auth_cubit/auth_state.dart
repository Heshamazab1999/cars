part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class UserRegisterLoadingState extends AuthState {}

class UserRegisterSuccessState extends AuthState {
  final RegisterModel userRegisterModel;

  UserRegisterSuccessState(this.userRegisterModel);
}

class UserRegisterErrorState extends AuthState {}

//--------------------------------------------------------------Register
class UserLoginLoadingState extends AuthState {}

class UserLoginSuccessState extends AuthState {
  final LoginModel userLoginModel;

  UserLoginSuccessState(this.userLoginModel);
}

class UserLoginErrorState extends AuthState {
  final String message;
  UserLoginErrorState(this.message);
}

//--------------------------------------------------------------login
class UserLogoutLoadingState extends AuthState {}

class UserLogoutSuccessState extends AuthState {
  final String message;

  UserLogoutSuccessState(this.message);
}

class UserLogoutErrorState extends AuthState {}

//----------------------------------------------------------logout
class UserForgetPasswordLoadingState extends AuthState {}

class UserForgetPasswordSuccessState extends AuthState {
  final String message;

  UserForgetPasswordSuccessState(this.message);
}

class UserForgetPasswordErrorState extends AuthState {}

//---------------------------------------------------forget password
class ChangePasswordLoadingState extends AuthState {}

class ChangePasswordSuccessState extends AuthState {
  final String message;

  ChangePasswordSuccessState(this.message);
}

class ChangePasswordErrorState extends AuthState {}

//--------------------------------------------------change password
class ChangeLanguageState extends AuthState {}

//----------------------------------------------- change language
class UpdateErrorState extends AuthState {}

class UpdateSuccessState extends AuthState {
  final String message;

  UpdateSuccessState(this.message);
}

class UpdateLoadingState extends AuthState {}

//------------------------------------------- update profile
class SuccessPickImageState extends AuthState {}

class ClearDataState extends AuthState {}

//----------------------------------------------- change language
class GetProfileErrorState extends AuthState {
  final String message;

  GetProfileErrorState(this.message);
}

class GetProfileSuccessState extends AuthState {}

class GetProfileLoadingState extends AuthState {}
