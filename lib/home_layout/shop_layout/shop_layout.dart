import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/search/search.dart';
import 'package:shop_app/shared/cubit/shop/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop/shop_states.dart';
import '../../shared/constant.dart';

class ShopLayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(


            appBar: AppBar(
       elevation:0.0,
              backgroundColor: Colors.white,
              title: Text('Salla',),
              actions: [IconButton(onPressed: ()
            {
               NavigatorTo(context,SearchScreen());

            },
               icon: Icon(Icons.search))],
            ),
            body: cubit.screenList[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.changeScreens(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favorite'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings')
              ],
            ));
      },
    );
  }
}
