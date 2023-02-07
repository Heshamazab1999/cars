import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {Key? key, required this.onTap, required this.icon, required this.title})
      : super(key: key);
  final void Function()? onTap;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: Colors.grey,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing:   const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
        ),
      ),
    );
  }
}
