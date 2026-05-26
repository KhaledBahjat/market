import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/theme/app_colors.dart';

class SignInWithGoogleButton extends StatelessWidget {
  const SignInWithGoogleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kWhiteColor,
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: BorderSide(color: AppColors.kGreyColor)
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icon/google.svg', height: 24.h, width: 24.w),
          Width(width: 10),
          Text(
            'Sign In with Google',
            style: TextStyle(
              color: Colors.red,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}