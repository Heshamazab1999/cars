import 'package:cars/core/components/profile_picture.dart';
import 'package:cars/core/enums/image_type.dart';
import 'package:cars/repositories/remote/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/navigation_utils.dart';
import '../../../cubits/auth_cubit/auth_cubit.dart';
import '../../auth/change_password/components/custom_button.dart';
import '../../auth/sign_in/login_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is UserLogoutSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.blue,
              duration: const Duration(seconds: 5),
            ));
            NavigationUtils.navigateAndClearStack(
                context: context, destinationScreen: const LoginScreen());
          }
        },
        builder: (context, state) {
          var cubit = AuthCubit.get(context);

          return Column(
            children: [
              ProfilePicture(
                  onTap: () {},
                  imageType: ImageType.network,
                  imageLink: PHOTO_USER + cubit.userProfileModel!.data!.photo!),
              const SizedBox(height: 20),
              ProfileMenu(
                text: cubit.userProfileModel!.data!.name!,
                icon: "assets/User Icon.svg",
                press: () => {},
              ),
              ProfileMenu(
                text: cubit.userProfileModel!.data!.email!,
                icon: "assets/Mail.svg",
                press: () {},
              ),
              ProfileMenu(
                text: cubit.userProfileModel!.data!.phone!,
                icon: "assets/Phone.svg",
                press: () {},
              ),
              ProfileMenu(
                text: cubit.userProfileModel!.data!.gender!,
                icon: "assets/User Icon.svg",
                press: () {},
              ),
              const Divider(),
              SizedBox(
                height: 20.h,
              ),
            ],
          );
        },
      ),
    );
  }
}
