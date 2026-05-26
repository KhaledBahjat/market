import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:market/core/routing/app_routs.dart';
import 'package:market/core/theme/app_colors.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          child: Text(
            'Forget Password?',
            style: TextStyle(
              color: AppColors.kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: ()=>GoRouter.of(context).go(AppRouts.forgetPasswordScreen),
        ),
      ],
    );
  }
}
