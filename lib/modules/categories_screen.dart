import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/models/category_data_model.dart';
import 'package:shop_application/share/remote/layout/shop_layout_cubit.dart';
import 'package:shop_application/share/remote/layout/shop_layout_states.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>
      (
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
            buildCategoriesItems(ShopLayoutCubit
                .get(context)
                .categoriesModel
                .data
                .data[index]), separatorBuilder: (context, index) =>
            SizedBox(
              width: 10.0,
            ), itemCount: ShopLayoutCubit
            .get(context)
            .categoriesModel
            .data
            .data
            .length);

      },

    );
  }

  Widget buildCategoriesItems(DataModel model) =>
      Row(
          children: [
            Image(image: NetworkImage(model.image),
              height: 90.0,
              width: 90.0,),
            SizedBox(width: 15.0,),
            Text(model.name,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600),),
            Spacer(),
            IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {}
            ),
          ]
      );

}
