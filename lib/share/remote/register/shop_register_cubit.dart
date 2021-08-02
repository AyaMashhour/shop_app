import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/models/login_screen_user_data.dart';

import 'package:shop_application/share/local/doi_helper.dart';
import 'package:shop_application/share/local/end_points.dart';
import 'package:shop_application/share/remote/register/shop_register_cubit.dart';
import 'package:shop_application/share/remote/register/shop_register_states.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  LoginModel loginModel;
  void userRegister({
    @required String email,
    @required String password,
    @required String phone,
    @required String name,
  })
  {
    emit(ShopRegisterSuccessState(loginModel));

    DioHelper.postData(
      url: REGISTER,
      data:
      {
        "name":name,
        "email": email,
        "password": password,
        "phone":phone
      },
    ).then((value)
    {
      print(value.data);
      loginModel=  LoginModel.fromJson(value.data);

     print(loginModel.status);

      emit(ShopRegisterSuccessState(loginModel));

    })
        .catchError((error)
    {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }



}
