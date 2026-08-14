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

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is SignUpError) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomErrorDialog(
                      message: state.errorMessage,
                    );
                  },
                );
              }

              if (state is SignUpSucces) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return CustomSuccessDialog(
                      message: state.message!,
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
              if (state is SignUpLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final cubit = context.read<AuthCubit>();

              return SingleChildScrollView(
                child: Form(
                  key: cubit.signUpFormKey,
                  child: Column(
                    children: [
                      Height(height: 50),

                      Text(
                        'Create Your Account Now',
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
                              const Height(height: 20),

                              CustomTextFormFeild(
                                labelText: 'Name',
                                hint: 'user Name',
                                controller: cubit.signUpNameController,
                              ),

                              Height(height: 20),

                              CustomTextFormFeild(
                                controller: cubit.signUpEmailController,
                                labelText: 'Email',
                              ),

                              const Height(height: 20),

                              CustomTextFormFeild(
                                controller: cubit.signUpPasswordController,
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

                              Height(height: 10),

                              CustomButton(
                                onPressed: () {
                                  if (cubit.signUpFormKey.currentState!
                                      .validate()) {
                                    cubit.signUpWithEmailAndPassword(
                                      email: cubit.signUpEmailController.text
                                          .trim(),
                                      password:
                                          cubit.signUpPasswordController.text,
                                    );
                                  }
                                },
                                buttonText: 'Sign Up',
                              ),

                              Height(height: 10),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Already have an account?',
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
