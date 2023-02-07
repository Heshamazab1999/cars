import 'package:cars/core/components/app_language.dart';
import 'package:cars/core/components/default_fade_in_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/setting_cubit/settings_cubit.dart';
import '../../../repositories/remote/end_points.dart';

class ContactUsScreen extends StatefulWidget {
  ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  void initState() {
    SettingsCubit.get(context).getContactUsInformation();
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
                getLang(context).contactUs,
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
                  child: state is ContactUsLoadingState
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.separated(
                          itemCount: cubit.contactUsObject!.brands!.length,
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
                                          DefaultFadeInNetworkImage(
                                              imageUrl: SETTINGS_PHOTO +
                                                  cubit.contactUsObject!
                                                      .brands![index].icon!),
                                          const SizedBox(height: 25),
                                          Text(
                                            "${cubit.contactUsObject!.brands![index].title}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "${cubit.contactUsObject!.brands![index].description}",
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
