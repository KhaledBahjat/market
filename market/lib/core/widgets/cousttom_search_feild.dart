import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/core/theme/app_colors.dart';

class CustomSearchFeild extends StatefulWidget {
  CustomSearchFeild({
    super.key,
    this.onPressed,
    this.controller,
  });
  void Function()? onPressed;
  TextEditingController? controller;

  @override
  State<CustomSearchFeild> createState() => _CustomSearchFeildState();
}

class _CustomSearchFeildState extends State<CustomSearchFeild> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        label: Text('Search in Market'),
        suffixIcon: ElevatedButton.icon(
          onPressed: widget.onPressed,
          label: Icon(Icons.search),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            iconSize: 30.sp,
            iconColor: AppColors.kWhiteColor,
          ),
        ),
        hintStyle: TextStyle(color: AppColors.kGreyColor),
        labelStyle: TextStyle(color: AppColors.kBlackColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.kBordersideColor,
            width: 2.sp,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.kBordersideColor,
            width: 2.sp,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.kBordersideColor,
            width: 2.sp,
          ),
        ),
      ),
    );
  }
}
