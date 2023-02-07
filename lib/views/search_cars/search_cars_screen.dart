import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/components/app_language.dart';
import '../../cubits/search_cubit/search_cubit.dart';
import '../home/components/item_home.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      builder: (context, state) {
        var cubit = SearchCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 9, 17, 75),
            title: Text(getLang(context).search),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(13.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      label: Text(getLang(context).search),
                      prefixIcon: const Icon(Icons.search),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                    ),
                    onChanged: (query) {
                      cubit.searchCars(query, context);
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${getLang(context).numberofresult} ${cubit.cars.length}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 4,
                              child: ItemHome(item: cubit.cars[index])),
                          const SizedBox(height: 10)
                        ],
                      );
                    },
                    itemCount: cubit.cars.length,
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
