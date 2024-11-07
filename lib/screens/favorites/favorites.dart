import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/favorite_model.dart';
import 'package:shop_app/shared/component/list_shared.dart';
import 'package:shop_app/shared/cubit/shop/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop/shop_states.dart';

import '../../shared/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is! ShopLoadingFavoriteDataState &&
                ShopCubit.get(context).homeModel != null,
            builder: (context) => ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildListProduct(
                      ShopCubit.get(context)
                          .favoriteModel!
                          .data!
                          .data![index].product!
                          ,context),
                  separatorBuilder: (context, index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300]),
                  itemCount:
                      ShopCubit.get(context).favoriteModel!.data!.data!.length,
                ),
            fallback: (context) => Center(
                    child: CircularProgressIndicator(
                  color: defaultColor,
                )));
      },
    );
  }
}


