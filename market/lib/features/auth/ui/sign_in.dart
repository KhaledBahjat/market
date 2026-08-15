import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/routing/app_routs.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/core/widgets/custom_success_widget.dart';
import 'package:market/core/widgets/error_widget.dart';
import 'package:market/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:market/features/auth/widgets/coustom_button.dart';
import 'package:market/features/auth/widgets/coustom_text_form_feild.dart';
import 'package:market/features/auth/widgets/forget_password_widget.dart';
import 'package:market/features/auth/widgets/sign_in_with_googlr_button.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is SignInError) {
                CustomErrorDialog(
                  message: state.errorMessage,
                );
              }

              if (state is SignInSucces) {
                context.pushReplacement(AppRouts.homeScreen);
              }

              if (state is GoogleSignInError) {
                CustomErrorDialog(
                  message: state.errorMessage,
                );
              }

              if (state is GoogleSignInSuccess) {
                context.pushReplacementNamed(AppRouts.homeScreen);
              }
              if (state is SignInError) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomErrorDialog(
                      message: state.errorMessage,
                    );
                  },
                );
              }

              if (state is SignInSucces) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return CustomSuccessDialog(
                      message: 'Login Success',
                      onPressed: () {
                        Navigator.pop(context);
                        context.pushReplacementNamed(AppRouts.homeScreen);
                      },
                    );
                  },
                );
                var cub = context.read<AuthCubit>();
                cub.signInEmailController.clear();
                cub.signInPasswordController.clear();
              }
            },
            builder: (context, state) {
              if (state is SignInLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final cubit = context.read<AuthCubit>();

              return SingleChildScrollView(
                child: Form(
                  key: cubit.signInFormKey,
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
                        margin: const EdgeInsets.all(24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.r),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Height(height: 20),

                              CustomTextFormFeild(
                                controller: cubit.signInEmailController,
                                labelText: 'Email',
                              ),

                              const Height(height: 20),

                              CustomTextFormFeild(
                                controller: cubit.signInPasswordController,
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
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility,
                                  ),
                                ),
                              ),

                              ForgetPasswordWidget(),

                              Height(height: 10),

                              CustomButton(
                                onPressed: () {
                                  if (cubit.signInFormKey.currentState!
                                      .validate()) {
                                    cubit.signInWithEmailAndPassword(
                                      email: cubit.signInEmailController.text
                                          .trim(),
                                      password:
                                          cubit.signInPasswordController.text,
                                    );
                                  }
                                },
                                buttonText: 'Sign In',
                              ),

                              Height(height: 10),

                              SignInWithGoogleButton(
                                isLoading: state is GoogleSignInLoading,
                                onPressed: () {
                                  context.read<AuthCubit>().signInWithGoogle();
                                },
                              ),

                              Height(height: 10),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Don\'t have an account?',
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.pushReplacement(
                                        AppRouts.signUpScreen,
                                      );
                                    },
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
              );
            },
          ),
        ),
      ),
    );
  }
}
