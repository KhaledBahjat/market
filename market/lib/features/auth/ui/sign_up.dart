import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/routing/app_routs.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/features/auth/widgets/coustom_button.dart';
import 'package:market/features/auth/widgets/coustom_text_form_feild.dart';


class SignUp extends StatelessWidget {
  SignUp({super.key});
  bool isPassword = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            // shield scrool when keybord shown
          
            child: Column(
              children: [
                Height(height: 50),
                Text(
                  'Create Your Account Now',
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
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
                        CustomTextFormFeild(labelText: 'Name',hint: 'user Name',),
                        Height(height: 20),
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
                            icon: Icon(
                              isPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                        Height(height: 10),
          
                        CustomButton(onPressed: () {}, buttonText: 'Sign Up'),
                        Height(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account?'),
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
