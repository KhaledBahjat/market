import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/core/theme/app_colors.dart';

class CustomTextFormFeild extends StatelessWidget {
  const CustomTextFormFeild({
    super.key, required this.labelText, this.suffixIcon, this.hint,
    this.obscureText,
  });
  final String labelText;
  final Widget? suffixIcon;
  final String ?hint;
  final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if(value==null){
          return 'this feild is requird';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      obscureText: obscureText?? false,
      decoration: InputDecoration(
        
        suffixIcon: suffixIcon,
        label: Text(labelText),
        hintText:hint?? 'userexample@example.com',
        hintStyle: TextStyle(color: AppColors.kGreyColor),
       labelStyle: TextStyle(color: AppColors.kBlackColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.kBordersideColor,
            width: 2.sp
          )
          
        ),
                  
        enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.kBordersideColor,
            width: 2.sp
          )
        ),
        focusedBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.kBordersideColor,
            width: 2.sp
          )
        )
      ),
    );
  }
}