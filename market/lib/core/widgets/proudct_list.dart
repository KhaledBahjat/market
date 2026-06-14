import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/core/logic/cubit/home_cubit.dart';
import 'package:market/core/model/product_model.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/core/widgets/proudct_card.dart';

class ProudctList extends StatelessWidget {
  const ProudctList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getProducts(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          List<ProductModel> products = context.read<HomeCubit>().products;
          return state is GetDataLoading? Center(
            child: CircularProgressIndicator(color: AppColors.kPrimaryColor,),
          ) : ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) => ProudctCard(),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          );
        },
      ),
    );
  }
}
