import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/app_language.dart';
import '../../../cubits/auth_cubit/auth_cubit.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
              title: Text(
                getLang(context).settings,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.grey[200],
              leading: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Color.fromARGB(255, 9, 17, 75),
                        ),
                        iconSize: 30,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Image.asset("assets/Settings.PNG")),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Card(
                    margin: const EdgeInsets.fromLTRB(35.0, 8.0, 32.0, 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(getLang(context).language),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => const AlertDialog(
                                      content: LangSwitch(
                                          isExpanded: true, width: 100),
                                    ));
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          width: double.infinity,
                          height: 1.0,
                          color: Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ),
//----------------------------------------------------- language
                  // state is UserLogoutLoadingState
                  //     ? const Center(
                  //         child: CircularProgressIndicator(),
                  //       )
                  //     : Card(
                  //         margin:
                  //             const EdgeInsets.fromLTRB(35.0, 8.0, 32.0, 16.0),
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(10.0),
                  //         ),
                  //         child: Column(
                  //           children: [
                  //             ListTile(
                  //               title: Text(getLang(context).logout),
                  //               trailing: const Icon(Icons.arrow_forward_ios),
                  //               onTap: () {
                  //                 cubit.userLogout(context);
                  //               },
                  //             ),
                  // Container(
                  //   margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  //   width: double.infinity,
                  //   height: 1.0,
                  //   color: Colors.grey.shade400,
                  // ),
                ],
              ),
            ),
          );
        });
  }
}
