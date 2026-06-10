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
          var signUpCubit = context.read<AuthCubit>();
          return Scaffold(
            body:state is SignUpLoading
                ? const Center(child: CircularProgressIndicator(
                    color: AppColors.kPrimaryColor,
                ))
                : SingleChildScrollView(
                    child: SafeArea(
                      // shield scrool when keybord shown
                      child: Form(
                        key: _formKey,
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
                        margin: EdgeInsets.all(24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.r)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const Height(height: 20),
                              CustomTextFormFeild(
                        
                                controller: _nameController,
                                labelText: 'Name',
                                hint: 'user Name',
                              ),
                              Height(height: 20),
                              CustomTextFormFeild(
                                controller: _emailController,
                                labelText: 'Email',
                                hint: 'user Email',
                              ),
                              const Height(height: 20),
                              CustomTextFormFeild(
                                controller: _passwordController,
                                obscureText: isPassword,
                                labelText: 'Password',
                                hint: '**************',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    isPassword = !isPassword;
                                    (context as Element).markNeedsBuild();
                                  },
                                  icon: Icon(
                                    isPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off_outlined,
                                  ),
                                ),
                              ),
                              Height(height: 10),
                        
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
        },
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
