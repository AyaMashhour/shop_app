import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/cubit/shop/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop/shop_states.dart';

import '../../model/categories_model.dart';

class CateogriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) => ConditionalBuilder(
            condition: ShopCubit.get(context).categoriesModel != null,
            builder: (context) => ListView.separated(
                  itemBuilder: (context, index) => buildCategoriesList(
                      ShopCubit.get(context)
                          .categoriesModel!
                          .dataModel
                          .categoriesdata[index]),
                  separatorBuilder: (context, index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300]),
                  itemCount: ShopCubit.get(context)
                      .categoriesModel!
                      .dataModel
                      .categoriesdata
                      .length,
                ),
            fallback: (context) => Center(
                  child: CircularProgressIndicator(
                    color: defaultColor,
                  ),
                )));
  }
}

Widget buildCategoriesList(DataModel model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
              height: 100,
              width: 100.0,
              child: CachedNetworkImage(
                imageUrl: model.image,
                fit: BoxFit.cover,
              )),
          SizedBox(
            width: 10.0,
          ),
          Text(
            model.name,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.arrow_forward_ios_rounded))
        ],
      ),
    );
