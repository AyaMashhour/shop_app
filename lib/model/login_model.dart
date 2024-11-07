import 'package:flutter/material.dart';

class ShopLoginModel {
 late  bool status;
  late String? message;
  late UserData data;

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? UserData.fromJson(json['data'])
        : json['message'];
  }
}

class UserData {
  late int id;
   String? name;
   String? email;
   String? phone;

   String? image;
   int? point;

   int? credit;
  late String token;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']??null;
    email = json['email']??null;
    phone = json['phone']??null;
    image = json['image']??null;
    point = json['point'];
    credit = json['credit']??null;
    token = json['token'];
  }
}
