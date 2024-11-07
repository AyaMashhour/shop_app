import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/home_model.dart';
import 'package:shop_app/screens/products/product_item.dart';
import 'package:shop_app/shared/cubit/shop/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop/shop_states.dart';

import '../../shared/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel != null &&ShopCubit.get(context).categoriesModel != null,
              builder: (context) =>
                  buildProductItem(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context),
              fallback: (context) => Center(
                    child: CircularProgressIndicator(color: defaultColor,),
                  ));
        });

}


}

