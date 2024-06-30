import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyIconsButton extends StatelessWidget {
  final Icon icon;
  final Color backgroundColor;
  const MyIconsButton({required this.icon, required this.backgroundColor,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 60.w,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.hardEdge,
      child:Center(
        child: icon,
      ),
    );
  }
}