import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/core/home_cubit/home_cubit.dart';
import 'package:market/core/proudct_model/proudct_model.dart';
import 'package:market/core/widgets/empty_widget.dart';
import 'package:market/core/widgets/proudct_card.dart';

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
          HomeCubit cubit = context.read<HomeCubit>();
          if (state is GetDataLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GetDataError) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          if (state is GetDataSuccess) {
            List<ProudctModel> products = query != null
                ? cubit.filterdProudcts
                : cubit.allProudcts;

            if (products.isEmpty && query != null) {
              return const Center(
                child: EmptyWidget(
                  icon: Icons.search_off_rounded,
                  title: 'No Results',
                  subtitle:
                      'We couldn\'t find any products matching your search.',
                ),
              );
            } else if (products.isEmpty) {
              return Center(
                child: EmptyWidget(
                  icon: Icons.inventory_2_outlined,
                  title: 'No Products',
                  subtitle: 'There are no products available right now.',
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
