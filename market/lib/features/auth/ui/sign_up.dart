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
import 'package:market/features/auth/widgets/show_error_message_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isPassword = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignUpFailure) {
            ShowErrorMessageWidget(message: state.errorMessage);
          }
          if (state is SignUpSuccess) {
            GoRouter.of(context).pushReplacement(AppRouts.signInScreen);
          }
        },
        builder: (context, state) {
          final signUpCubit = context.read<AuthCubit>();

          return Scaffold(
            body: state is SignUpLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.kPrimaryColor,
                    ),
                  )
                : SingleChildScrollView(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF1E293B),
                                      Color(0xFF111827),
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
                                      'Create Your Account',
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
                                      'Join the market, save products, and shop in a clean dark interface.',
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
                                        controller: _nameController,
                                        labelText: 'Name',
                                        hint: 'user Name',
                                      ),
                                      const Height(height: 18),
                                      CustomTextFormFeild(
                                        controller: _emailController,
                                        labelText: 'Email',
                                        hint: 'user Email',
                                      ),
                                      const Height(height: 18),
                                      CustomTextFormFeild(
                                        controller: _passwordController,
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
                                      const Height(height: 10),
                                      CustomButton(
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            signUpCubit.signUpWithEmailAndPassword(
                                              name: _nameController.text,
                                              email: _emailController.text,
                                              password: _passwordController.text,
                                            );
                                          }
                                        },
                                        buttonText: 'Sign Up',
                                      ),
                                      const Height(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Already have an account?',
                                            style: TextStyle(
                                              color: AppColors.kGreyColor,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () => GoRouter.of(
                                              context,
                                            ).pushReplacement(
                                              AppRouts.signInScreen,
                                            ),
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
                  ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}