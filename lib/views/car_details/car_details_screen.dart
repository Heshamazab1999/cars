import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/components/app_language.dart';
import '../../core/components/default_fade_in_image.dart';
import '../../cubits/home_cubit/home_cubit.dart';
import '../../models/car_model/car_model.dart' as cars;
import '../../repositories/remote/end_points.dart';
import 'components/car_component.dart';

class CarDetailsScreen extends StatelessWidget {
  CarDetailsScreen({Key? key, this.item}) : super(key: key);
  cars.Cars? item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromARGB(255, 9, 17, 75),
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text(
          item!.name!,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.6,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.6,
                      child: DefaultFadeInNetworkImage(
                        imageUrl: CARS_PHOTO + item!.images![index],
                        boxFit: BoxFit.fill,
                      ),
                    );
                  },
                  itemCount: item!.images!.length,
                )),
            Padding(
                padding: const EdgeInsets.all(50.0),
                child: Container(
                    clipBehavior: Clip.hardEdge,
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10)))),
            scrollingContainer(),
          ],
        ),
      ),
    );
  }

  scrollingContainer() {
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 1.0,
        minChildSize: 0.6,
        expand: true,
        builder: (context, scrollController) {
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 245, 248, 253),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFirstSector(context),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Text(getLang(context).description,
                          style: TextStyle(
                            color: Color.fromARGB(255, 9, 17, 75),
                            fontSize: 20,
                          )),
                    ),
                    // Divider(),
                    SizedBox(
                      height: 4,
                    ),
                    _buildThirdContainer(context),
                    _buildSecondContainer(context),
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Text(getLang(context).availableColors,
                          style: TextStyle(
                            color: Color.fromARGB(255, 9, 17, 75),
                            fontSize: 20,
                          )),
                    ),
                    Container(
                      height: 100,
                      padding: const EdgeInsets.all(10),
                      // color: const Color.fromARGB(255, 225, 225, 225),
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 20),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Color(int.parse(
                                    "0xff${item!.colors![index].value!.substring(1)}")),
                                radius: 15,
                              ),
                              Text(item!.colors![index].name!)
                            ],
                          );
                        },
                        itemCount: item!.colors!.length,
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Column(children: [
                        Text(
                          getLang(context).companyDetails,
                          style: TextStyle(
                            color: Color.fromARGB(255, 9, 17, 75),
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(HomeCubit.get(context)
                            .companyModel!
                            .companies!
                            .firstWhere((element) =>
                                element.id.toString() == item!.companyId)
                            .phone1!),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(HomeCubit.get(context)
                            .companyModel!
                            .companies!
                            .firstWhere((element) =>
                                element.id.toString() == item!.companyId)
                            .phone2!),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(HomeCubit.get(context)
                            .companyModel!
                            .companies!
                            .firstWhere((element) =>
                                element.id.toString() == item!.companyId)
                            .address!),
                      ]),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 9, 17, 75),
                                    ),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22.0),
                                    ))),
                                onPressed: () {
                                  _launchUrl( HomeCubit.get(context)
                                      .companyModel!
                                      .companies!
                                      .firstWhere((element) =>
                                  element.id.toString() ==
                                      item!.companyId)
                                      .location!);

                                },
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    getLang(context).openLocation,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "${item!.price!} \$",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 9, 17, 75),
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _buildFirstSector(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 19.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getLang(context).specifications,
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 9, 17, 75),
            ),
          ),
        ],
      ),
    );
  }

  _buildSecondContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            CarComponentItem(
              value: item!.brands!.name!,
              label: getLang(context).brand,
              type: "brand",
              image: HomeCubit.get(context)
                  .brandModel!
                  .brands!
                  .firstWhere((element) => element.id == item!.id)
                  .image,
            ),
            const SizedBox(width: 10),
            CarComponentItem(
              value: item!.companies!.name!,
              label: getLang(context).company,
              type: "company",
              image: HomeCubit.get(context)
                  .companyModel!
                  .companies!
                  .firstWhere(
                      (element) => element.id.toString() == item!.companyId)
                  .image!,
            ),
          ],
        ),
      ),
    );
  }

  _buildThirdContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Text(
        item!.description!,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  static Future<void> openMap(BuildContext context, String url) async {
    if (Platform.isAndroid) {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } else {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    }
  }
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
}}
