import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/modules/search_screen.dart';
import 'package:shop_application/share/component/component.dart';
import 'package:shop_application/share/remote/layout/shop_layout_cubit.dart';
import 'package:shop_application/share/remote/layout/shop_layout_states.dart';

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(icon: Icon(Icons.search),onPressed: ()
              {
                navigateTo(context, SearchScreen());
              },)

            ],
          ),
          body: cubit.showScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavigationBar(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
