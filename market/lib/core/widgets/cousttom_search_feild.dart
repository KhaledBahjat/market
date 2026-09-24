// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:market/core/theme/app_colors.dart';

class CustomSearchFeild extends StatelessWidget {
  const CustomSearchFeild({
    super.key,
    this.controller,
    this.onPressed,
    this.focusNode,
    this.onChanged,
  });
  final TextEditingController? controller;
  final void Function()? onPressed;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      focusNode: focusNode,
      controller: controller,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        label: Text('Search in Market'),
        hintStyle: TextStyle(color: AppColors.kGreyColor),
        labelStyle: TextStyle(color: AppColors.kBlackColor),
        suffix: Icon(Icons.search,size: 30,color: AppColors.kPrimaryColor,),
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
