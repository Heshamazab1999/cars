import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DefaultCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double imageWidth;
  final double imageHeight;
  const DefaultCachedNetworkImage({
    Key? key,
    required this.imageUrl,
    required this.imageHeight,
    required this.imageWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: imageWidth,
      height: imageHeight,
      imageUrl: imageUrl,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[850]!,
        highlightColor: Colors.grey[800]!,
        child: Container(
          height: imageHeight,
          width: imageWidth,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(8.0.r),
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: BoxFit.cover,
    );
  }
}
