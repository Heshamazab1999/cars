import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/car_model/car_model.dart';
import '../home_cubit/home_cubit.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);

  List<Cars> cars = [];
  void searchCars(String? search, BuildContext context) {
    cars = [];

    for (var element in HomeCubit.get(context)
        .carModel!
        .cars!
        .where((element) => element.name!.toLowerCase().contains(search!))
        .toList()) {
      if (!cars.contains(element)) {
        cars.add(element);
      }
    }

    for (var element in HomeCubit.get(context)
        .carModel!
        .cars!
        .where(
            (element) => element.brands!.name!.toLowerCase().contains(search!))
        .toList()) {
      if (!cars.contains(element)) {
        cars.add(element);
      }
    }

    for (var element in HomeCubit.get(context)
        .carModel!
        .cars!
        .where((element) =>
            element.companies!.name!.toLowerCase().contains(search!))
        .toList()) {
      if (!cars.contains(element)) {
        cars.add(element);
      }
    }

    emit(SearchResultState());
  }
}
