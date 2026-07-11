import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/core/theme/app_colors.dart';

class CustomTextFormFeild extends StatelessWidget {
  const CustomTextFormFeild({
    super.key,
    required this.labelText,
    this.suffixIcon,
    this.hint,
    this.obscureText,
    this.controller,
  });
  final String labelText;
  final Widget? suffixIcon;
  final String? hint;
  final bool? obscureText;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'this $labelText is required';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        label: Text(labelText),
        hintText: hint ?? 'userexample@example.com',
        hintStyle: TextStyle(color: AppColors.kGreyColor),
        labelStyle: TextStyle(color: AppColors.kWhiteColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.kBordersideColor,
            width: 2.sp,
          ),
        ),
        filled: true,
        fillColor: const Color(0xFF0F172A),

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
            color: AppColors.kPrimaryColor,
            width: 2.sp,
          ),
        ),
      ),
      style: TextStyle(color: AppColors.kWhiteColor),
    );
  }
}
