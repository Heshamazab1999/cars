import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/components/app_language.dart';
import '../../core/components/default_cached_network_image.dart';
import '../../core/utils/navigation_utils.dart';
import '../../cubits/auth_cubit/auth_cubit.dart';
import '../../repositories/remote/end_points.dart';
import '../../views/edit_profile/edit_profile_screen.dart';
import '../../views/profile/profle_screen.dart';
import '../../views/settings/about_us/about_us.dart';
import '../../views/settings/contact_us/contact_us.dart';
import '../../views/settings/faqs/faqs_screen.dart';
import '../../views/settings/settings_screen/settings_screen.dart';
import 'drawer_item.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SafeArea(
          child: Drawer(
            backgroundColor: Colors.grey[100],
            child: state is GetProfileLoadingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DefaultCachedNetworkImage(
                                      imageUrl:
                                          '$PHOTO_USER${AuthCubit.get(context).userProfileModel!.data!.photo}',
                                      imageHeight: 80,
                                      imageWidth: 60,
                                    ))),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 150.w,
                                  child: AutoSizeText(
                                    AuthCubit.get(context)
                                        .userProfileModel!
                                        .data!
                                        .name!,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      getLang(context).editProfile,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 9, 17, 75),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          NavigationUtils.navigateTo(
                                              context: context,
                                              destinationScreen:
                                                  EditProfileScreen());
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          size: 16,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey[300],
                        height: 50,
                        endIndent: 40,
                        indent: 40,
                        thickness: 1,
                      ),
                      DrawerItem(
                          onTap: () {
                            NavigationUtils.navigateTo(
                                context: context,
                                destinationScreen: ProfileScreen());
                          },
                          icon: Icons.person,
                          title: getLang(context).profile),
                      DrawerItem(
                          onTap: () {
                            NavigationUtils.navigateTo(
                                context: context,
                                destinationScreen: SettingScreen());
                          },
                          icon: Icons.settings,
                          title: getLang(context).settings),
                      DrawerItem(
                          onTap: () {
                            NavigationUtils.navigateTo(
                                context: context,
                                destinationScreen: AboutUsScreen());
                          },
                          icon: Icons.info_outline,
                          title: getLang(context).aboutUs),
                      DrawerItem(
                          onTap: () {
                            NavigationUtils.navigateTo(
                                context: context,
                                destinationScreen: ContactUsScreen());
                          },
                          icon: Icons.feedback_outlined,
                          title: getLang(context).contactUs),
                      DrawerItem(
                          onTap: () {
                            NavigationUtils.navigateTo(
                                context: context,
                                destinationScreen: FAQSScreen());
                          },
                          icon: Icons.contact_support_outlined,
                          title: getLang(context).fAQs),
                      state is UserLogoutLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : DrawerItem(
                              onTap: () async {
                                await AuthCubit.get(context)
                                    .userLogout(context);
                              },
                              icon: Icons.logout,
                              title: getLang(context).logout),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
