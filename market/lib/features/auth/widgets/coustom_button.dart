import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
   CustomButton({
    super.key, this.onPressed, required this.buttonText,
  });
  final void Function()? onPressed;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kPrimaryColor,
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: AppColors.kWhiteColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

