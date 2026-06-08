import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/routing/app_routs.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/features/auth/logic/cubit/auth_cubit.dart';
import 'package:market/features/auth/widgets/coustom_button.dart';
import 'package:market/features/auth/widgets/coustom_text_form_feild.dart';
import 'package:market/features/auth/widgets/forget_password_widget.dart';
import 'package:market/features/auth/widgets/show_error_message_widget.dart';
import 'package:market/features/auth/widgets/sign_in_with_googlr_button.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isPassword = false;

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            ShowErrorMessageWidget(message: state.errorMessage);
          }
        },
        builder: (context, state) {
          AuthCubit authCubit = context.read<AuthCubit>();

          return Scaffold(
            body: state is LoginLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.kPrimaryColor,
                    ),
                  )
                : SingleChildScrollView(
                    child: SafeArea(
                      child: Form(
                        key: formKey,
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
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16.r),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Height(height: 20),
                                    CustomTextFormFeild(
                                      controller: emailController,
                                      labelText: 'Email',
                                    ),
                                    const Height(height: 20),
                                    CustomTextFormFeild(
                                      controller: passwordController,
                                      obscureText: isPassword,
                                      labelText: 'Password',
                                      hint: '**************',
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isPassword = !isPassword;
                                          });
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
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          authCubit.loginWithEmailAndPassword(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          );
                                        }
                                      },
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
                                          onPressed: () =>
                                              GoRouter.of(
                                                context,
                                              ).pushReplacement(
                                                AppRouts.signUpScreen,
                                              ),
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
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
