import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/components/default_fade_in_image.dart';
import '../../../core/style/colors.dart';
import '../../../core/utils/navigation_utils.dart';
import '../../../cubits/home_cubit/home_cubit.dart';
import '../../../models/car_model/car_model.dart' as cars;
import '../../../repositories/remote/end_points.dart';
import '../../car_details/car_details_screen.dart';

class ItemHome extends StatelessWidget {
  ItemHome({super.key, required this.item});
  cars.Cars item;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.height * .3),
      width: (MediaQuery.of(context).size.width),
      child: Stack(
        children: [
          Positioned(
            top: 2.h,
            left: 0.w,
            right: 0.w,
            child: Container(
              padding: EdgeInsets.only(left: 25.w, top: 45.h),
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.4),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 0.5,
                        blurRadius: 15)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
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
                            item.brands!.name!,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            item.companies!.name!,
                          ),
                          // Divider(
                          //   color: Colors.black,
                          // ),
                          Text(
                            item.models != null ? item.models!.year! : "",
                          ),

                          Text(
                            "${item.price!}\$",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 9, 17, 75),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 80.h,
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
                                            element.id.toString() ==
                                            item.companyId)
                                        .phone1!,
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 9, 17, 75),
                                        fontSize: 15)),
                                Text(
                                    HomeCubit.get(context)
                                        .companyModel!
                                        .companies!
                                        .firstWhere((element) =>
                                            element.id.toString() ==
                                            item.companyId)
                                        .phone2!,
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 9, 17, 75),
                                        fontSize: 15)),
                                SizedBox(height: 10.h)
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          //---
          // ---------------------------------button
         SizedBox(width: 100,
           height: 20,
           child: TextButton(onPressed: (){
             print("object");
             NavigationUtils.navigateTo(
                 context: context,
                      destinationScreen: CarDetailsScreen(item: item));
           }, child: Text("hhh"),
           style: TextButton.styleFrom(
             backgroundColor: Colors.red
           )),
         ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       print("object");
                // NavigationUtils.navigateTo(
                //     context: context,
                //     destinationScreen: CarDetailsScreen(item: item));
          //     },
          //     style: ElevatedButton.styleFrom(
          //       minimumSize: Size(150, 50),
          //       backgroundColor: AppColors.primarySwatchColor,
          //       elevation: 0,
          //       shape: const RoundedRectangleBorder(
          //         borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(20),
          //           bottomRight: Radius.circular(20),
          //         ),
          //       ),
          //     ),
          //     child: const Text(
          //       "Details",
          //     ),
          //   ),
          // ),
          //------------------------------------------photos
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 180.w,
              height: 220.h,
              child: DefaultFadeInNetworkImage(
                  imageUrl: CARS_PHOTO + item.images![0]),
            ),
          ),
        ],
      ),
    );
  }
}
