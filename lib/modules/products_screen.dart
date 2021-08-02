import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/models/category_data_model.dart';
import 'package:shop_application/models/home_data_model.dart';
import 'package:shop_application/share/component/component.dart';
import 'package:shop_application/share/remote/layout/shop_layout_cubit.dart';
import 'package:shop_application/share/remote/layout/shop_layout_states.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state)
      {
        if(state is FavoriteSuccessHomeData)
          if(!state.model.status)
            flutterToast(text: state.model.message,state: ToastStates.ERROR);
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).homeModel != null &&
              ShopLayoutCubit.get(context).categoriesModel != null,
          builder: (context) => productBuilder
            (
              ShopLayoutCubit.get(context).homeModel,
              ShopLayoutCubit.get(context).categoriesModel,
              context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

Widget productBuilder(
        HomeModel model, CategoriesModel categoriesModel, context) =>
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
              items: model.data.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ))
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                height: 200.0,
                autoPlayAnimationDuration: Duration(seconds: 1),
                initialPage: 0,
                autoPlayInterval: Duration(seconds: 3),
                scrollDirection: Axis.horizontal,
                autoPlayCurve: Curves.fastOutSlowIn,
                viewportFraction: 1.0,
              )),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildListCategories(categoriesModel.data.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 14.0,
                          ),
                      itemCount: categoriesModel.data.data.length),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text('New Product',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1.0 / 1.68,
                children: List.generate(
                    model.data.products.length,
                    (index) =>
                        buildGridProduct(model.data.products[index], context))),
          )
        ],
      ),
    );

Widget buildListCategories(DataModel dataModel) => Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Image(
          image: NetworkImage('${dataModel.image}'),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
            width: 100.0,
            color: Colors.black.withOpacity(0.5),
            child: Text(
              dataModel.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ))
      ],
    );

Widget buildGridProduct(ProductModel productModel, context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(productModel.image),
                height: 200.0,
                width: double.infinity,
              ),
              if (productModel.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  color: Colors.red,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productModel.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12.0),
                ),
                Row(
                  children: [
                    Text(
                      '${productModel.price}',
                      style: TextStyle(fontSize: 16.0, color: Colors.blue),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (productModel.discount != 0)
                      Text(
                        '${productModel.oldPrice.round()}',
                        style: TextStyle(
                            fontSize: 13.5,
                            color: Colors.grey[500],
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopLayoutCubit.get(context)
                            .changeFavorites(productModel.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor: ShopLayoutCubit.get(context).favorites[productModel.id]?defaultColor:Colors.grey,
                        child: Icon(

                          Icons.favorite_border,
                          color: Colors.white,
                          size: 17.0,
                        ),
                        radius: 15.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
