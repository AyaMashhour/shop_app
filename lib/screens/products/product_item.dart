import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/categories_model.dart';
import 'package:shop_app/model/change_favorite_model.dart';
import 'package:shop_app/shared/colors.dart';
import '../../shared/component/component_login.dart';
import 'products.dart';
import 'package:shop_app/shared/cubit/shop/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop/shop_states.dart';

import '../../model/home_model.dart';

Widget buildProductItem(
    HomeModel? model, CategoriesModel? categoriesModel, context) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model!.data.banners
                    .map((element) => Image(
                          image: NetworkImage('${element.image}'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ))
                    .toList(),
                options: CarouselOptions(
                    height: 200,
                    viewportFraction: 1.0,
                    autoPlay: true,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    scrollDirection: Axis.horizontal,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayInterval: Duration(seconds: 3))),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 120.0,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoriesList(
                            categoriesModel.dataModel.categoriesdata[index]),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10.0,
                            ),
                        itemCount:
                            categoriesModel!.dataModel.categoriesdata.length),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'NewProduct',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.56,
                crossAxisCount: 2,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(
                  model.data.products.length,
                  (index) =>
                      buildGridProduct(model.data.products[index], context),
                ),
              ),
            )
          ],
        );
      },
    ),
  );
}

Widget buildGridProduct(ProductsModel products, context) =>
    BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
       if(state is ShopSuccessChangeFavoriteState)
         {
           if (!state.model.status!){
             showToast(text: state.model.message,state: ToastStates.ERROR);
           }
         }
      },
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  CachedNetworkImage(
                    imageUrl: '${products.image}',
                    errorListener: (error) {
                      print(error.toString());
                    },
                    width: double.infinity,
                    height: 170.0,
                  ),
                  if (products.discount != 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        color: Colors.red,
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(color: Colors.white, fontSize: 8.0),
                        ),
                      ),
                    )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      '${products.name}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(fontSize: 14.0, height: 1.3),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${products.price.round()}',
                          style: TextStyle(fontSize: 12.0, color: defaultColor),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        if (products.discount != 0)
                          Text(
                            '${products.oldPrice.round()}',
                            style: TextStyle(
                                fontSize: 12.0,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey),
                          ),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor:
                              ShopCubit.get(context).favorite![products.id]!
                                  ? defaultColor
                                  : Colors.grey,
                          child: IconButton(
                              onPressed: () {
                                ShopCubit.get(context)
                                    .changeFavorite(products.id);
                                print('${products.id}');
                              },
                              icon: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

Widget buildCategoriesList(DataModel model) => Container(
      width: 120.0,
      height: 120.0,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            child: CachedNetworkImage(
              imageUrl: '${model.image}',
              errorListener: (error) {
                print(error.toString());
              },
              fit: BoxFit.cover,
            ),
          ),
          Container(
              width: 120.0,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
              ),
              child: Text(
                '${model.name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
