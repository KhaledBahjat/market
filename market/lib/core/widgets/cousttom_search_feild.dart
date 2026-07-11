import 'package:flutter/material.dart';
import 'package:market/core/theme/app_colors.dart';

class CustomSearchFeild extends StatelessWidget {
  const CustomSearchFeild({
    super.key,
    this.onPressed,
    this.controller,
  });

  final void Function()? onPressed;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search products, brands, or categories',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(6),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              backgroundColor: AppColors.kPrimaryColor,
              foregroundColor: AppColors.kWhiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Icon(Icons.arrow_forward_rounded),
          ),
        ),
      ),
    );
  }
}
