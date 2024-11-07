import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/login_model.dart';
import 'package:shop_app/shared/cubit/login/login_states.dart';
import 'package:shop_app/shared/natwork/dio_helper.dart';

import '../../natwork/end_point.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(url: LOGIN,
        data: {'email': email, 'password': password})
        .then((value) {
    print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel.status);

      print(loginModel.message);
      print(loginModel.data.name);

      emit(ShopLoginSuccessState(loginModel));

    }).catchError((error) {
      print(error.toString());
     emit(ShopLoginErrorState(error.toString()));
    });
  }

  bool isPassword = false;
  IconData suffix = Icons.visibility_outlined;

  void changevisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopLoginShowPasswordState());
  }
}
