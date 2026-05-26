import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Width extends StatelessWidget {
  const Width({super.key, required this.width});
final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width.w,);
  }
}

class Height extends StatelessWidget {
  const Height({super.key, required this.height});
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height.h,);
  }
}