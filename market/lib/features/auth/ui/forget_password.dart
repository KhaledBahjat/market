import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/routing/app_routs.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/features/auth/widgets/coustom_button.dart';
import 'package:market/features/auth/widgets/coustom_text_form_feild.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Height(height: 50),
                Text(
                  'Reset Your Password',
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                ),
                Height(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Enter your email and we\'ll send you a link to reset your password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
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
                        const Height(height: 20),
                        CustomTextFormFeild(labelText: 'Email'),
                        const Height(height: 20),
                        CustomButton(
                          onPressed: () {
                            // TODO: Implement reset password logic
                          },
                          buttonText: 'Reset Password',
                        ),
                        Height(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Remember your password?'),
                            TextButton(
                              onPressed: () => GoRouter.of(
                                context,
                              ).pushReplacement(AppRouts.signInScreen),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: AppColors.kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
