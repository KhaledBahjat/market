import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/core/home_cubit/home_cubit.dart';
import 'package:market/core/widgets/proudct_card.dart';

class ProudctList extends StatelessWidget {
  const ProudctList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getProducts(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
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
            final products = state.products;
            if (products.isEmpty) {
              return const Center(
                child: Text('No products found'),
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
