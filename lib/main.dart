import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/shared/cubit/search/search_cubit.dart';
import 'package:shop_app/shared/cubit/search/search_cubit.dart';
import 'package:shop_app/shared/cubit/search/search_cubit.dart';
import 'package:shop_app/shared/cubit/shop/shop_cubit.dart';
import 'package:shop_app/shared/natwork/cache_helper.dart';
import 'package:shop_app/shared/natwork/dio_helper.dart';
import 'package:shop_app/shared/theme/dark_theme.dart';
import 'package:shop_app/shared/theme/light_theme.dart';

import 'home_layout/onboarding_screen.dart';
import 'home_layout/shop_layout/shop_layout.dart';
import 'shared/cubit/observe.dart';
import 'shared/cubit/search/search_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  String? token = CacheHelper.getData(key: 'token');
  print(token);

  print(onBoarding);
  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayoutScreen();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    onBoarding: onBoarding ?? true,
    startwidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool onBoarding;
  final Widget startwidget;

  const MyApp({required this.onBoarding,
    required this.startwidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..getProfileData()..getFavoriteData(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          home: startwidget),
    );
  }
}
