import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/about_us_model/about_us_model.dart';
import '../../models/contact_us_model/contact_us_model.dart';
import '../../models/faqs_model/faqs_model.dart';
import '../../repositories/local/cache_keys.dart';
import '../../repositories/remote/dio_helper.dart';
import '../../repositories/remote/end_points.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  static SettingsCubit get(context) => BlocProvider.of(context);
  // List<BrandsAboutUs> aboutUsData = [];

  // List<BrandsContactUs> contactUsData = [];
  // List<Brands> faQsData = [];
  ContactUSModel? contactUsObject;
  getContactUsInformation() async {
    emit(ContactUsLoadingState());
    await DioHelper.postDataWithToken(url: CONTACT_US, data: {}, query: {
      "lang": CacheKeysManger.getLanguageFromCache(),
    }).then((value) {
      if (value.statusCode == 200) {
        contactUsObject = ContactUSModel.fromJson(value.data);
        emit(ContactUsSuccessState());
      } else {
        debugPrint(value.data.toString());
        emit(ContactUsErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ContactUsErrorState());
    });
  }

  //------------------------------------------------contact us
  AboutUSModel? aboutUsModel;
  getAboutUsInformation() async {
    emit(AboutUsLoadingState());
    await DioHelper.postDataWithToken(url: ABOUT_US, data: {}, query: {
      "lang": CacheKeysManger.getLanguageFromCache(),
    }).then((value) {
      if (value.statusCode == 200) {
        aboutUsModel = AboutUSModel.fromJson(value.data);
        emit(AboutUsSuccessState());
      } else {
        debugPrint(value.data.toString());
        emit(AboutUsErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(AboutUsErrorState());
    });
  }

//--------------------------------------- About us

  FAQSModel? faQsModel;
  getFAQsInformation() async {
    emit(FAQsLoadingState());
    await DioHelper.postDataWithToken(url: FAQS, data: {}, query: {
      "lang": CacheKeysManger.getLanguageFromCache(),
    }).then((value) {
      if (value.statusCode == 200) {
        faQsModel = FAQSModel.fromJson(value.data);
        emit(FAQsSuccessState());
      } else {
        debugPrint(value.data.toString());
        emit(FAQsErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(FAQsErrorState());
    });
  }

  //------------------------------------------------ FAQS
}
