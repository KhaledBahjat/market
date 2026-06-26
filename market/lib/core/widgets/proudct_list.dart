import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/core/logic/cubit/home_cubit.dart';
import 'package:market/core/model/product_model.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/core/widgets/proudct_card.dart';

class ProudctList extends StatelessWidget {
  const ProudctList({
    super.key,
    this.query,
    this.category,
  });
  final String? query;
  final String? category;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit()..getProducts(query: query, category: category),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          HomeCubit cubit = context.read<HomeCubit>();
          List<ProductModel> products = query != null
              ? context.read<HomeCubit>().searchResults
              : category != null
              ? context.read<HomeCubit>().categoryResults
              : context.read<HomeCubit>().products;
          return state is GetDataLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kPrimaryColor,
                  ),
                )
              : products.isEmpty
              ? Center(
                  child: Text(
                    'No results found',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) => ProudctCard(
                    products[index],
                    onPressed: () {
                      cubit.addProductToFavorite(products[index].proudctId);
                    },
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                );
        },
      ),
    );
  }
}
