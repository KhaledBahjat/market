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

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is ForgotPasswordError) {
                showDialog(
                  context: context,
                  builder: (_) {
                    return CustomErrorDialog(
                      message: state.errorMessage,
                    );
                  },
                );
              }

              if (state is ForgotPasswordSuccess) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) {
                    return CustomSuccessDialog(
                      message: state.message,
                      onPressed: () {
                        Navigator.pop(context);
                        context.go(AppRouts.signInScreen);
                      },
                    );
                  },
                );
              }
            },
            builder: (context, state) {
              final bool isLoading = state is ForgotPasswordLoading;

              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Height(height: 50),

                      Text(
                        'Reset Your Password',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Height(height: 16),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        child: Text(
                          'Enter your email and we\'ll send you '
                          'a link to reset your password',
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
                              const Height(height: 20),

                              CustomTextFormFeild(
                                controller: emailController,
                                labelText: 'Email',
                              ),

                              const Height(height: 20),

                              CustomButton(
                                onPressed: isLoading
                                    ? null
                                    : () {
                                        if (formKey.currentState!.validate()) {
                                          context
                                              .read<AuthCubit>()
                                              .forgotPassword(
                                                email: emailController.text
                                                    .trim(),
                                              );
                                        }
                                      },
                                buttonText: isLoading
                                    ? 'Sending...'
                                    : 'Reset Password',
                              ),

                              Height(height: 16),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Remember your password?',
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.pushReplacement(
                                        AppRouts.signInScreen,
                                      );
                                    },
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
              );
            },
          ),
        ),
      ),
    );
  }
}
