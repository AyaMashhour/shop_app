import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/models/login_screen_user_data.dart';
import 'package:shop_application/share/local/doi_helper.dart';
import 'package:shop_application/share/local/end_points.dart';
import 'package:shop_application/share/remote/login/shop_login_states.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
 ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context)=>BlocProvider.of(context);

LoginModel loginModel;
 void userLogin({
   @required String email,
   @required String password,
 })
 {
   emit(ShopLoginLoadingState());

   DioHelper.postData(
     url: LOGIN,
     data:
     {
       "email": email,
       "password": password,
     },
   ).then((value)
   {
     print(value.data);
   loginModel=  LoginModel.fromJson(value.data);

    // print(loginModel.status);
    // print(loginModel.message);
    // print(loginModel.data.token);
    emit(ShopLoginSuccessState(loginModel));

 })
.catchError((error)
   {
    print(error.toString());
     emit(ShopLoginErrorState(error.toString()));
   });
 }



}
