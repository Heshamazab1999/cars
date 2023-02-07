import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/components/app_language.dart';
import '../../core/utils/navigation_utils.dart';
import '../../cubits/auth_cubit/auth_cubit.dart';
import '../../cubits/home_cubit/home_cubit.dart';
import '../../layout/main/main_screen.dart';
import '../../repositories/remote/end_points.dart';
import '../filter_cars/filter_screen.dart';
import '../search_cars/search_cars_screen.dart';
import 'components/category_item.dart';
import 'components/item_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _getData();
    super.initState();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  _getData() async {
    await AuthCubit.get(context).getProfile();
    await HomeCubit.get(context).loadHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
              key: scaffoldKey,
              drawer: const MyDrawer(),
              body: SingleChildScrollView(child: _buildBody(cubit, state)));
        });
  }

//-------------------------------start of stack
  _buildBody(HomeCubit cubit, HomeState state) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(128.0),
              child: GestureDetector(
                onTap: () {
                  NavigationUtils.navigateTo(
                      context: context, destinationScreen: SearchScreen());
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white.withOpacity(1)),
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 20),
                      Text(getLang(context).search),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getLang(context).brand,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 124, 122, 122),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 6,
                child: (cubit.brandModel != null)
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: cubit.brandModel!.brands!.length,
                        itemBuilder: (context, index) {
                          var item = cubit.brandModel!.brands![index];
                          return GestureDetector(
                              onTap: () {
                                NavigationUtils.navigateTo(
                                    context: context,
                                    destinationScreen: FilterScreen(
                                      brandId:
                                          cubit.brandModel!.brands![index].id!,
                                    ));
                              },
                              child: CategoryItem(item: item));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 4,
                          );
                        },
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
            //-----------------------------------------------end of brands
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 180,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    reverse: false,
                  ),
                  itemCount: cubit.carouselSliderBanner.length,
                  itemBuilder: (context, index, i) {
                    return cubit.carouselSliderBanner.isNotEmpty
                        ? Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  "https://cars.efada-academy.com/images/banners/${cubit.carouselSliderBanner[index]}",
                                ),
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ),
            ),
            //------------------------------end of banner
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getLang(context).trendingCars,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 124, 122, 122),
                      fontSize: 18,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      NavigationUtils.navigateTo(
                          context: context, destinationScreen: SearchScreen());
                    },
                    child: Text(
                      getLang(context).seeAll,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 9, 17, 75),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //--------------------------------------------------end of see all
            state is GetHomeDataSuccessState
                ? SizedBox(
                    height: (MediaQuery.of(context).size.height * .4),
                    child: ListView.builder(
                      itemCount: cubit.carModel!.cars!.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var item = cubit.carModel!.cars![index];
                        return ItemHome(item: item);
                      },
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
        // -----------------------------------------------------------------------first stack in bottom

        Stack(
          children: [
            Container(),
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                ),
              ),
            ),
            Container(
              height: 280,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 9, 17, 75),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(75),
                  // bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          left: 4,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 33,
                          ),
                          onPressed: () {
                            if (scaffoldKey.currentState!.isDrawerOpen) {
                              scaffoldKey.currentState!.closeDrawer();
                            } else {
                              scaffoldKey.currentState!.openDrawer();
                            }
                          },
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                            top: 43.0,
                            // right: 5,
                          ),
                          child: BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              return AuthCubit.get(context).userProfileModel !=
                                      null
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          right: getLang(context).localeName ==
                                                  "ar"
                                              ? 0
                                              : 15,
                                          left: getLang(context).localeName ==
                                                  "ar"
                                              ? 15
                                              : 0),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            '$PHOTO_USER${AuthCubit.get(context).userProfileModel!.data!.photo}'),
                                        radius: 30,
                                      ),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator());
                            },
                          ))
                    ],
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        top: 15,
                      ),
                      child: Text(
                        "Welcome Back",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(27.0),
                        child: GestureDetector(
                          onTap: () {
                            NavigationUtils.navigateTo(
                                context: context,
                                destinationScreen: SearchScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 20.0,
                              left: 9,
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 46,
                              decoration: BoxDecoration(
                                  // border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white.withOpacity(0.7)),
                              child: Row(
                                children: [
                                  const SizedBox(width: 20),
                                  const Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 20),
                                  Text(getLang(context).search),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
