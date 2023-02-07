import 'package:cars/core/components/app_language.dart';
import 'package:cars/repositories/remote/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/components/profile_picture.dart';
import '../../core/enums/image_type.dart';
import '../../cubits/auth_cubit/auth_cubit.dart';
import '../auth/change_password/components/custom_button.dart';
import 'components/default_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is UpdateSuccessState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.message),
          backgroundColor: Colors.blue,
          duration: const Duration(seconds: 5),
        ));
      }
    }, builder: (context, state) {
      var cubit = AuthCubit.get(context);
      nameController.text = cubit.userProfileModel!.data!.name!;
      emailController.text = cubit.userProfileModel!.data!.email!;
      phoneController.text = cubit.userProfileModel!.data!.phone!;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(getLang(context).editProfile),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.all(20.w),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfilePicture(
                      imageType: AuthCubit.get(context).photo != null
                          ? ImageType.file
                          : ImageType.network,
                      imageLink: AuthCubit.get(context).photo ??
                          "$PHOTO_USER${AuthCubit.get(context).userProfileModel!.data!.photo!}",
                      onTap: () {
                        AuthCubit.get(context).pickImage();
                      },
                    ),
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    // Stack(
                    //   children: [
                    //     SizedBox(
                    //       width: double.infinity,
                    //       child: selectImage(),
                    //     ),
                    //     Positioned(
                    //         bottom: 0,
                    //         right: 0,
                    //         child: Container(
                    //           height: 35,
                    //           width: 35,
                    //           decoration: BoxDecoration(
                    //               color: AppColors.primaryColor,
                    //               shape: BoxShape.circle,
                    //               border: Border.all(
                    //                   width: 2, color: Colors.white)),
                    //           child: InkWell(
                    //             onTap: () {
                    //               _showSelectPhotoOptions(context);
                    //             },
                    //             child: const Icon(
                    //               Icons.camera,
                    //               color: Colors.white,
                    //             ),
                    //           ),
                    //         ))
                    //   ],
                    // ),

                    SizedBox(
                      height: 30.h,
                    ),
                    DefaultTextFormField(
                      hintText: getLang(context).user_name_text_field,
                      controller: nameController,
                      icon: Icons.person,
                      type: TextInputType.text,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return getLang(context).user_name_text_field;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    DefaultTextFormField(
                      hintText: getLang(context).email_text_field,
                      controller: emailController,
                      icon: Icons.email,
                      type: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return getLang(context).email_validate;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    DefaultTextFormField(
                      hintText: getLang(context).phone_text_field,
                      controller: phoneController,
                      icon: Icons.call,
                      type: TextInputType.phone,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return getLang(context).phone_validate;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    state is UpdateLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Align(
                            alignment: AlignmentDirectional.center,
                            child: CustomButton(
                              text: getLang(context).save,
                              onPressed: (() {
                                if (formKey.currentState!.validate()) {
                                  cubit.updateProfile(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              }),
                            ),
                          ),
                  ],
                ),
              ),
            )),
      );
    });
  }
}
