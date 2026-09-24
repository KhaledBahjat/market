import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/home_cubit/home_cubit.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/core/widgets/cousttom_search_feild.dart';
import 'package:market/core/widgets/proudct_card.dart';
import 'package:market/core/widgets/empty_widget.dart';
import 'package:market/features/home/widgets/categorys_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..getProducts(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final List<String> imgs = [
    'assets/imgs/market.jpg',
    'assets/imgs/market.jpg',
    'assets/imgs/test.jpg',
  ];

  final TextEditingController _searchController =
      TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: ListView(
        children: [
          Height(height: 15),

          // ================= SEARCH =================

          CustomSearchFeild(
            controller: _searchController,
            onChanged: (value) {
              context.read<HomeCubit>().search(value);

              setState(() {});
            },
          ),

          Height(height: 20),

          // ================= CONTENT =================

          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final cubit = context.read<HomeCubit>();

              // Loading
              if (state is GetDataLoading &&
                  cubit.allProudcts.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // Error
              if (state is GetDataError &&
                  cubit.allProudcts.isEmpty) {
                return Center(
                  child: Text(
                    state.errorMessage,
                    textAlign: TextAlign.center,
                  ),
                );
              }

              // ================= SEARCH MODE =================

              if (_searchController.text.trim().isNotEmpty) {
                return _buildSearchResults(cubit);
              }

              // ================= NORMAL HOME =================

              return _buildHomeContent();
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SEARCH RESULTS
  // ============================================================

  Widget _buildSearchResults(HomeCubit cubit) {
    if (cubit.filterdProudcts.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: 80.h),
        child: Column(
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 70.sp,
              color: Colors.grey,
            ),

            SizedBox(height: 15.h),

            Text(
              'No products found',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              'Try searching for another product',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${cubit.filterdProudcts.length} Products Found',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.kPrimaryColor
          ),
        ),

        Height(height: 10),

        ListView.builder(
          itemCount: cubit.filterdProudcts.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ProudctCard(
              proudct: cubit.filterdProudcts[index],
            );
          },
        ),
      ],
    );
  }

  // ============================================================
  // NORMAL HOME
  // ============================================================

  Widget _buildHomeContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ================= CAROUSEL =================

        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
          child: CarouselSlider.builder(
            itemCount: imgs.length,
            itemBuilder: (
              context,
              index,
              realIndex,
            ) {
              return Image.asset(
                imgs[index],
                height: 200.h,
                width: double.infinity,
                fit: BoxFit.fill,
              );
            },
            options: CarouselOptions(
              height: 200.h,
              viewportFraction: 1,
              enableInfiniteScroll: imgs.length > 1,
              autoPlay: imgs.length > 1,
              autoPlayInterval: const Duration(
                seconds: 3,
              ),
              autoPlayAnimationDuration:
                  const Duration(
                milliseconds: 800,
              ),
              enlargeCenterPage: false,
            ),
          ),
        ),

        Height(height: 20),

        // ================= CATEGORIES =================

        Text(
          'Popular Categories',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),

        Height(height: 10),

        const CategorysList(),

        Height(height: 10),

        // ================= RECENTLY ADDED =================

        Text(
          'Recently Added',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),

        Height(height: 10),

        _buildRecentlyAdded(),
      ],
    );
  }

  // ============================================================
  // RECENTLY ADDED
  // ============================================================

  Widget _buildRecentlyAdded() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();

        if (state is GetDataLoading &&
            cubit.allProudcts.isEmpty) {
          return const SizedBox.shrink();
        }

        if (cubit.allProudcts.isEmpty) {
          return const EmptyWidget(
            icon: Icons.inventory_2_outlined,
            title: 'No Products',
            subtitle:
                'There are no products available right now.',
          );
        }

        return ListView.builder(
          itemCount: cubit.allProudcts.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ProudctCard(
              proudct: cubit.allProudcts[index],
            );
          },
        );
      },
    );
  }
}