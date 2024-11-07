import 'package:flutter/material.dart';
import 'package:shop_app/model/boarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget boardingItem(BoardingModel model, {controller, onChange}) =>
    Padding(
      padding: EdgeInsets.all(20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                  height: 120,
                  child: Image(
                      height: 120, image: AssetImage('${model.image}'))),
            ),
            Text(
              '${model.title}',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              '${model.body}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 40,
            ),

          ]),
    );




