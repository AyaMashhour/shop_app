import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/login_model.dart';
import 'package:shop_app/shared/cubit/login/login_states.dart';
import 'package:shop_app/shared/cubit/register/register_state.dart';
import 'package:shop_app/shared/natwork/dio_helper.dart';

import '../../natwork/end_point.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
   ShopLoginModel ?loginModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(url: REGISTER, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone
    }).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel?.status);

      print(loginModel?.message);
      print(loginModel?.data.name);

      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  bool isPassword = false;
  IconData suffix = Icons.visibility_outlined;

  void changevisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopRegisterShowPasswordState());
  }
}
