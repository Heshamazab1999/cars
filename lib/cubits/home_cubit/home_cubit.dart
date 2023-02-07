import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/banner_model/banner_model.dart';
import '../../models/brand_model/brand_model.dart';
import '../../models/car_model/car_model.dart';
import '../../models/company_model/company_model.dart';
import '../../models/filter_cars_model/filter_cars_model.dart';
import '../../models/models_cars_model/models_cars_model.dart';
import '../../repositories/local/cache_keys.dart';
import '../../repositories/remote/dio_helper.dart';
import '../../repositories/remote/end_points.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  List<String> carouselSliderBanner = [];
  List<CarsFilter> carsFilter = [];

  getBanner() async {
    emit(BannersLoadingState());
    await DioHelper.postData(
      url: BANNER,
      data: {},
    ).then((value) {
      final BannerModel bannerModel = BannerModel.fromJson(value.data);
      for (var element in bannerModel.banners!) {
        carouselSliderBanner.add(element.banner!);
      }
      emit(BannersSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(BannersErrorState());
    });
  }

  CarModel? carModel;
  getAllCars() async {
    emit(GetCarsLoadingState());
    await DioHelper.postData(
      url: ALL_CARS,
      data: {"lang": CacheKeysManger.getLanguageFromCache()},
    ).then((value) {
      if (value.statusCode == 200) {
        carModel = CarModel.fromJson(value.data);
        emit(GetCarsSuccessState());
      } else {
        debugPrint(value.data.toString());
        emit(GetCarsErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetCarsErrorState());
    });
  }

  CompanyModel? companyModel;
  getAllCompanies() async {
    emit(GetCompaniesLoadingState());
    await DioHelper.postData(
      url: ALL_COMPANIES,
      data: {"lang": CacheKeysManger.getLanguageFromCache()},
    ).then((value) {
      if (value.statusCode == 200) {
        companyModel = CompanyModel.fromJson(value.data);
        emit(GetCompaniesSuccessState());
      } else {
        debugPrint(value.data.toString());
        emit(GetCompaniesErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetCompaniesErrorState());
    });
  }

  BrandModel? brandModel;
  getAllBrands() async {
    emit(GetBrandsLoadingState());
    await DioHelper.postData(
      url: ALL_BRANDS,
      data: {"lang": CacheKeysManger.getLanguageFromCache()},
    ).then((value) {
      if (value.statusCode == 200) {
        brandModel = BrandModel.fromJson(value.data);
        emit(GetBrandsSuccessState());
      } else {
        debugPrint(value.data.toString());
        emit(GetBrandsErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetBrandsErrorState());
    });
  }

  CarModelModel? carModelModel;
  getAllModelCars() async {
    emit(GetModelsLoadingState());
    await DioHelper.postData(
      url: ALL_MODELS,
      data: {"lang": CacheKeysManger.getLanguageFromCache()},
    ).then((value) {
      if (value.statusCode == 200) {
        carModelModel = CarModelModel.fromJson(value.data);
        emit(GetModelsSuccessState());
      } else {
        debugPrint(value.data.toString());
        emit(GetModelsErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetModelsErrorState());
    });
  }

//-----------------------------------------------filter

  FilterCarsModel? filterCarModelModel;
  getAllFiltersCars(int brandId) async {
    emit(GetFilterLoadingState());
    await DioHelper.postData(
      url: FILTER_CARS,
      data: {"lang": CacheKeysManger.getLanguageFromCache(), "id": brandId},
    ).then((value) {
      if (value.statusCode == 200) {
        filterCarModelModel = FilterCarsModel.fromJson(value.data);
        emit(GetFilterSuccessState());
      } else {
        print(value.data.toString());
        emit(GetFilterErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetFilterErrorState());
    });
  }

//------------------------
  loadHomeData() async {
    emit(GetHomeDataLoadingState());
    await getAllCars();
    await getAllBrands();
    await getAllCompanies();
    await getAllModelCars();
    emit(GetHomeDataSuccessState());
  }
}
