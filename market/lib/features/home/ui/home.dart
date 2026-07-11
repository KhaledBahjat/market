import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/routing/app_routs.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/core/widgets/cousttom_search_feild.dart';
import 'package:market/core/widgets/proudct_list.dart';
import 'package:market/features/home/widgets/categorys_list.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1E293B),
                const Color(0xFF0F172A),
              ],
            ),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: AppColors.kBordersideColor.withValues(alpha: 0.8),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Discover products you will actually want',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.kWhiteColor,
                ),
              ),
              const Height(height: 8),
              Text(
                'Browse fast, search instantly, and keep your favorites in one place.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.kGreyColor,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              CustomSearchFeild(
                controller: searchController,
                onPressed: () {
                  GoRouter.of(context).pushNamed(
                    AppRouts.searchScreen,
                    extra: searchController.text,
                  );
                  searchController.clear();
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.2),
              BlendMode.darken,
            ),
            child: Image.asset(
              'assets/imgs/market.jpg',
              fit: BoxFit.cover,
              height: 180,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Popular Categories',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'See all',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const CategorysList(),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recently Added',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Fresh picks',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black54,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const ProudctList(),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
