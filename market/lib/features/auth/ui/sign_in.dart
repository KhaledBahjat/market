import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/features/auth/widgets/coustom_text_form_feild.dart';

class SignIn extends StatelessWidget {
   SignIn({super.key});
  bool isPassword = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Height(height: 150),
              Text(
                'Welcome To Our Market',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Height(height: 24),
              Card(
                color: AppColors.kWhiteColor,
                margin: EdgeInsets.all(24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.r)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CustomTextFormFeild(labelText: 'Email'),
                      const Height(height: 20),
                      CustomTextFormFeild(
                        obscureText: isPassword,
                        labelText: 'Password',
                        hint: '**************',
                        suffixIcon: IconButton(
                          onPressed: () {
                            isPassword = !isPassword;
                          },
                          icon:  Icon(isPassword ? Icons.visibility : Icons.visibility_off_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
