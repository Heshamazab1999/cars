import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/components/default_fade_in_image.dart';
import '../../../core/style/colors.dart';
import '../../../core/utils/navigation_utils.dart';
import '../../../cubits/home_cubit/home_cubit.dart';
import '../../../models/car_model/car_model.dart' as cars;
import '../../../repositories/remote/end_points.dart';
import '../../models/filter_cars_model/filter_cars_model.dart';
import '../car_details/car_details_screen.dart';

class CarOfBrandItem extends StatelessWidget {
  CarOfBrandItem({super.key, required this.item});
  CarsFilter item;
  // carsFilter.CarsFilter item;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.height * .3),
      width: (MediaQuery.of(context).size.width),
      child: Stack(
        children: [
          Positioned(
            top: 5.h,
            left: 0.w,
            right: 0.w,
            child: Container(
              padding: EdgeInsets.only(left: 25.w, top: 50.h),
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 0.5,
                        blurRadius: 15)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15.w, right: 4.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item.nameEn!,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Divider(
                        //   color: Colors.black,
                        // ),
                        // Text(
                        //   item.models != null ? item.models!.year! : "",
                        // ),

                        Text(
                          "${item.price!}\$",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 9, 17, 75),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 75.h,
                        child: Column(
                          children: [
                            // Text(item.name!,
                            //     style: const TextStyle(
                            //         color: Color.fromARGB(255, 9, 17, 75),
                            //         fontSize: 20)),
                            Text(
                                HomeCubit.get(context)
                                    .companyModel!
                                    .companies!
                                    .firstWhere((element) =>
                                        element.id.toString() == item.companyId)
                                    .phone1!,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 9, 17, 75),
                                    fontSize: 15)),
                            Text(
                                HomeCubit.get(context)
                                    .companyModel!
                                    .companies!
                                    .firstWhere((element) =>
                                        element.id.toString() == item.companyId)
                                    .phone2!,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 9, 17, 75),
                                    fontSize: 15)),
                            SizedBox(height: 10.h)
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          //------------------------------------button
          Positioned(
            bottom: 22.h,
            right: 10.w,
            child: SizedBox(
              width: 130.w,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  // NavigationUtils.navigateTo(
                  //     context: context,
                  //     destinationScreen: CarDetailsScreen(item: item));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueColor,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                ),
                child: const Text(
                  "Details",
                ),
              ),
            ),
          ),
          //------------------------------------------photos
          Positioned(
            top: 0.h,
            left: 11.w,
            child: SizedBox(
              width: 140.w,
              height: 153.h,
              child: DefaultFadeInNetworkImage(
                  imageUrl: CARS_PHOTO + item.images![0]),
            ),
          ),
        ],
      ),
    );
  }
}
