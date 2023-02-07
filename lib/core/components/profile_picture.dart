import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../enums/image_type.dart';
import 'default_cached_network_image.dart';

class ProfilePicture extends StatelessWidget {
  ProfilePicture(
      {Key? key,
      required this.onTap,
      required this.imageType,
      required this.imageLink,
      this.size,
      this.hasEdit = true})
      : super(key: key);
  Function onTap;
  ImageType imageType;
  dynamic imageLink;
  double? size;
  bool hasEdit;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: size ?? 50.r,
              backgroundColor: Colors.grey,
              backgroundImage: const AssetImage("assets/user.png"),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: (imageLink == null)
                    ? null
                    : (imageType == ImageType.file)
                        ? Image.file(imageLink,
                            height: 120.h, width: 120.w, fit: BoxFit.cover)
                        : (imageType == ImageType.network)
                            ? DefaultCachedNetworkImage(
                                imageUrl: imageLink,
                                imageHeight: 120.h,
                                imageWidth: 120.w,
                              )
                            : null,
              ),
            ),
            if (hasEdit)
              CircleAvatar(
                radius: 17.r,
                backgroundColor: Colors.grey[150],
                child: const Icon(Icons.edit),
              ),
          ],
        ),
      ),
    );
  }
}
