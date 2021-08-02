import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/layout/layout_screen.dart';
import 'package:shop_application/share/local/cache_helper.dart';
import 'package:shop_application/share/local/doi_helper.dart';
import 'package:shop_application/share/remote/bloc_observe.dart';
import 'package:shop_application/share/remote/layout/shop_layout_cubit.dart';
import 'package:shop_application/share/remote/layout/shop_layout_states.dart';
import 'modules/login_screen.dart';
import 'share/local/end_points.dart';
import 'share/theme/light_theme.dart';
import 'modules/on_boarding_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
Bloc.observer = MyBlocObserver();
DioHelper.init();


bool  onBoarding=CacheHelper.getData(key: 'onBoarding');
  token=CacheHelper.getData(key: 'token');

print(onBoarding);
  print(token);
  Widget widget;
  if(onBoarding!=null){
    if(token!=null) widget=LayoutScreen();
    else widget=LoginScreen();
  }
  else widget =OnBoardingScreen();

  runApp(MyApp(onBoarding,widget));
}

class MyApp extends StatelessWidget {
  final bool onBoarding;
  final Widget startWidget;
  MyApp(this.onBoarding,this.startWidget) ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShopLayoutCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getProfileData(),

      child: BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
        listener: (context,state){},
        builder: (context ,state)
        {
          return MaterialApp(
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },

      ),
    );
  }
}
