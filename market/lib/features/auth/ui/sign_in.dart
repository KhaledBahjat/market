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
  const SignIn({super.key});

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
          if (state is LoginFailure || state is GoogleSignInFailure) {
            ShowErrorMessageWidget(
              message: state is LoginFailure
                  ? state.errorMessage
                  : (state as GoogleSignInFailure).errorMessage,
            );
          }
          if (state is LoginSuccess || state is GoogleSignInSuccess) {
            GoRouter.of(context).pushReplacement(AppRouts.homeScreen);
          }
        },
        builder: (context, state) {
          AuthCubit authCubit = context.read<AuthCubit>();

          return Scaffold(
            body: state is LoginLoading || state is GoogleSignInLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.kPrimaryColor,
                    ),
                  )
                : SingleChildScrollView(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      const Color(0xFF1E293B),
                                      const Color(0xFF111827),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(28),
                                  border: Border.all(
                                    color: AppColors.kBordersideColor,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome Back',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            fontSize: 26.sp,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.kWhiteColor,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Sign in to continue shopping, saving, and tracking your orders.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: AppColors.kGreyColor,
                                            height: 1.4,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Card(
                                color: const Color(0xFF121B2E),
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(24.r),
                                  ),
                                  side: BorderSide(
                                    color: AppColors.kBordersideColor,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Column(
                                    children: [
                                      const Height(height: 10),
                                      CustomTextFormFeild(
                                        controller: emailController,
                                        labelText: 'Email',
                                      ),
                                      const Height(height: 18),
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
                                      const SizedBox(height: 6),
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
                                      const Height(height: 10),
                                      SignInWithGoogleButton(
                                        onPressed: () => authCubit.signInWithGoogle(),
                                      ),
                                      const Height(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Don\'t have an account?',
                                            style: TextStyle(
                                              color: AppColors.kGreyColor,
                                            ),
                                          ),
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
