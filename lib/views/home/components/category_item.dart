import 'package:flutter/material.dart';

import '../../../models/brand_model/brand_model.dart';
import '../../../repositories/remote/end_points.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({Key? key, this.item}) : super(key: key);
  Brands? item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: MediaQuery.of(context).size.width / 4.3,
      // height: 192,
      decoration: BoxDecoration(
          // color: Colors.white.withOpacity(01),
          // borderRadius: BorderRadius.circular(50),
          ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(height: 16),
        Expanded(
          child: CircleAvatar(
            backgroundImage: NetworkImage(BRANDS_PHOTO + item!.image!),
          ),
        ),
        Text(
          item!.name!,
        ),
        const SizedBox(height: 16),
      ]),
    );
  }
}
