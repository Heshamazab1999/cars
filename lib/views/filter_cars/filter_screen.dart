import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/components/app_language.dart';
import '../../cubits/home_cubit/home_cubit.dart';
import 'car_of_brand_item.dart';

// ignore: must_be_immutable
class FilterScreen extends StatefulWidget {
  FilterScreen({Key? key, required this.brandId}) : super(key: key);
  int brandId;
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeCubit.get(context).getAllFiltersCars(widget.brandId);
    print(widget.brandId);
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 9, 17, 75),
            title: Text("Filter"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(13.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // TextFormField(
                  //   controller: searchController,
                  //   keyboardType: TextInputType.text,
                  //   decoration: InputDecoration(
                  //     label: Text(getLang(context).search),
                  //     prefixIcon: const Icon(Icons.search),
                  //     border: const OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(
                  //         Radius.circular(20.0),
                  //       ),
                  //     ),
                  //   ),
                  //   onChanged: (query) {
                  //     cubit.searchCars(query, context);
                  //   },
                  // ),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${getLang(context).numberofresult} ${cubit.carsFilter.length}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  (state is GetFilterLoadingState)
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                ),
                                CarOfBrandItem(
                                    item: cubit
                                        .filterCarModelModel!.cars![index]),
                                const SizedBox(height: 10)
                              ],
                            );
                          },
                          itemCount: cubit.filterCarModelModel!.cars!.length,
                        )
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
//}
}
