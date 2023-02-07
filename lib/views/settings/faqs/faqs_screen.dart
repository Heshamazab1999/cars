import 'package:cars/core/components/app_language.dart';
import 'package:cars/core/components/default_fade_in_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/setting_cubit/settings_cubit.dart';
import '../../../repositories/remote/end_points.dart';

class FAQSScreen extends StatefulWidget {
  FAQSScreen({Key? key}) : super(key: key);

  @override
  State<FAQSScreen> createState() => _FAQSScreenState();
}

class _FAQSScreenState extends State<FAQSScreen> {
  @override
  void initState() {
    SettingsCubit.get(context).getFAQsInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SettingsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                getLang(context).fAQs,
                style: const TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
            ),
            body: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1.6,
                  child: state is FAQsLoadingState
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.separated(
                          itemCount: cubit.faQsModel!.brands!.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) => Card(
                                elevation: 2,
                                child: Padding(
                                    padding: const EdgeInsets.all(35),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "${cubit.faQsModel!.brands![index].title}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "${cubit.faQsModel!.brands![index].description}",
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ])),
                              )),
                ),
              ],
            ),
          );
        });
  }
}
