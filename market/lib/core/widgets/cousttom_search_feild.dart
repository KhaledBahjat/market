import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/core/theme/app_colors.dart';

class CustomSearchFeild extends StatelessWidget {
  const CustomSearchFeild({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: Text('Search in Market'),
        suffixIcon: ElevatedButton.icon(
          onPressed: () {},
          label: Icon(Icons.search),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
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
