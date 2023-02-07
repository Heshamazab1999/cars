import 'package:flutter/material.dart';

import '../../../core/components/default_fade_in_image.dart';
import '../../../repositories/remote/end_points.dart';

class CarComponentItem extends StatelessWidget {
  CarComponentItem({Key? key, this.type, this.image, this.label, this.value})
      : super(key: key);
  String? label;
  String? value;
  String? image;
  String? type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      // height: 100,
      decoration: BoxDecoration(
        // color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            image != null
                ? SizedBox(
                    width: 70,
                    height: 70,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: DefaultFadeInNetworkImage(
                        imageUrl: type == "brand"
                            ? BRANDS_PHOTO + image!
                            : type == "company"
                                ? COMPANIES_PHOTO + image!
                                : "",
                        boxFit: BoxFit.fill,
                      ),
                    ),
                  )
                : Image.asset(
                    'assets/image.png',
                    //color: Colors.grey,
                    width: 80,
                    height: 40,
                  ),
            Text(label!, style: TextStyle(fontSize: 16, color: Colors.black)),
            Text(
              value!,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
