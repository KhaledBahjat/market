import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/routing/app_routs.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/features/auth/widgets/coustom_button.dart';
import 'package:market/features/auth/widgets/coustom_text_form_feild.dart';
import 'package:market/features/auth/widgets/forget_password_widget.dart';
import 'package:market/features/auth/widgets/sign_in_with_googlr_button.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  bool isPassword = false;
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
                  'Welcome To Our Market',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
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
                        ForgetPasswordWidget(),
                        Height(height: 10),

                        CustomButton(
                          onPressed: () => GoRouter.of(
                            context,
                          ).pushReplacementNamed(AppRouts.homeScreen),
                          buttonText: 'Sign In',
                        ),
                        Height(height: 10),
                        // TODO: sign in with google
                        SignInWithGoogleButton(),
                        Height(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(
                              onPressed: () => GoRouter.of(
                                context,
                              ).pushReplacement(AppRouts.signUpScreen),
                              child: Text(
                                'Sign Up',
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
