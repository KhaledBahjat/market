import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/core/home_cubit/home_cubit.dart';
import 'package:market/core/proudct_model/proudct_model.dart';
import 'package:market/core/widgets/empty_widget.dart';
import 'package:market/core/widgets/proudct_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProudctList extends StatelessWidget {
  const ProudctList({
    super.key,
    this.query,
    this.categoryName,
  });

  final String? query, categoryName;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getProducts(query: query,categoryName: categoryName),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final HomeCubit cubit = context.read<HomeCubit>();

          // Loading
          if (state is GetDataLoading) {
            return Skeletonizer(
              enabled: true,
              child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ProudctCard(
                    proudct: ProudctModel(
                      proudctName: 'Product Name',
                      proudctPrice: '999',
                      imageUrls: 'assets/imgs/test.jpg',
                    ),
                  );
                },
              ),
            );
          }

          // Error
          if (state is GetDataError) {
            return Center(
              child: Text(state.errorMessage),
            );
          }

          // Success
          if (state is GetDataSuccess) {
            final List<ProudctModel> products = query != null
                ? cubit.filterdProudcts
                : categoryName != null
                ? cubit.proudctsByCategory
                : cubit.allProudcts;

            if (products.isEmpty) {
              final bool isSearch = query != null && query!.trim().isNotEmpty;
              final bool isCategory =
                  categoryName != null && categoryName!.trim().isNotEmpty;

              return Center(
                child: EmptyWidget(
                  icon: isSearch
                      ? Icons.search_off_rounded
                      : isCategory
                      ? Icons.category_outlined
                      : Icons.inventory_2_outlined,
                  title: isSearch
                      ? 'No Results'
                      : isCategory
                      ? 'No Products in This Category'
                      : 'No Products',
                  subtitle: isSearch
                      ? 'We couldn\'t find any products matching your search.'
                      : isCategory
                      ? 'There are no products available in this category right now.'
                      : 'There are no products available right now.',
                ),
              );
            }

            return ListView.builder(
              itemCount: products.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ProudctCard(
                  proudct: products[index],
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
