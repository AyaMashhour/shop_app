import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/colors.dart';

import '../../model/favorite_model.dart';
import '../cubit/shop/shop_cubit.dart';

Widget buildListProduct(data, context,{bool isOldPrice=true}) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(right: 20.0),
            height: 120,
            width: 120.0,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                CachedNetworkImage(
                  imageUrl: '${data.image}',
                  fit: BoxFit.cover,
                  errorListener: (error) {
                    print(error.toString());
                  },
                  width: 120.0,
                  height: 120.0,
                ),
                if (data.discount != 0&&isOldPrice)
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
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${data.name}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontSize: 14.0, height: 1.3),
                ),
                SizedBox(height: 20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      data.price.toString(),
                      style: TextStyle(fontSize: 12.0, color: defaultColor),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    if (data.discount != 0&&isOldPrice)
                      Text(
                        '${data.oldPrice}',
                        style: TextStyle(
                            fontSize: 12.0,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey),
                      ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor:
                          ShopCubit.get(context).favorite![data.id]!
                              ? defaultColor
                              : Colors.grey,
                      child: IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorite(data.id);
// print('${products.id}');
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
