import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowErrorMessageWidget extends StatelessWidget {
  const ShowErrorMessageWidget({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.redAccent,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
