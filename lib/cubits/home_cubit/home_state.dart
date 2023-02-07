part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

//! ///////////////////////////////////////////////////
class BannersLoadingState extends HomeState {}

class BannersSuccessState extends HomeState {}

class BannersErrorState extends HomeState {}

//! ///////////////////////////////////////////////////
class GetModelsLoadingState extends HomeState {}

class GetModelsSuccessState extends HomeState {}

class GetModelsErrorState extends HomeState {}

//! ///////////////////////////////////////////////////
class GetCompaniesLoadingState extends HomeState {}

class GetCompaniesSuccessState extends HomeState {}

class GetCompaniesErrorState extends HomeState {}

//! ///////////////////////////////////////////////////
class GetCarsLoadingState extends HomeState {}

class GetCarsSuccessState extends HomeState {}

class GetCarsErrorState extends HomeState {}

//! ///////////////////////////////////////////////////
class GetBrandsLoadingState extends HomeState {}

class GetBrandsSuccessState extends HomeState {}

class GetBrandsErrorState extends HomeState {}

//! ///////////////////////////////////////////////////
class GetHomeDataLoadingState extends HomeState {}

class GetHomeDataSuccessState extends HomeState {}

class GetHomeDataErrorState extends HomeState {}

//--------------------------------------------
class GetFilterLoadingState extends HomeState {}

class GetFilterSuccessState extends HomeState {}

class GetFilterErrorState extends HomeState {}
