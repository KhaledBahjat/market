import 'package:flutter/material.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/core/widgets/proudct_list.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF121B2E),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.kBordersideColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to our store!',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.kWhiteColor,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Explore deals, favorites, and fresh arrivals.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.kGreyColor,
                      ),
                ),
              ],
            ),
          ),
          Height(height: 18),
          const ProudctList(),
        ],
      ),
    );
  }
}