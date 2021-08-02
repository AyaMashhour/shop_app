import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_application/share/component/component.dart';
import 'package:shop_application/share/local/end_points.dart';
import 'package:shop_application/share/remote/layout/shop_layout_cubit.dart';
import 'package:shop_application/share/remote/layout/shop_layout_states.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
     BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
        listener: (context,state)
        {},
        builder: (context,state)
        {
          return ConditionalBuilder(
            condition: state is! ShopLoadingFavoriteScreen ,
            builder: (context)=>ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildListItems(ShopLayoutCubit.get(context).favouriteModel.data.data[index].product,context),
                separatorBuilder: (context, index) =>
                    Container(
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                itemCount:ShopLayoutCubit.get(context).favouriteModel.data.data.length),
            fallback: (context)=>Center(
              child: CircularProgressIndicator(),
            ),

    );

  });}


}
