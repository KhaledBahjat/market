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
  });

  final String? query;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getProducts(query: query),
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
                : cubit.allProudcts;

            if (products.isEmpty) {
              return Center(
                child: EmptyWidget(
                  icon: query != null
                      ? Icons.search_off_rounded
                      : Icons.inventory_2_outlined,
                  title: query != null ? 'No Results' : 'No Products',
                  subtitle: query != null
                      ? 'We couldn\'t find any products matching your search.'
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
