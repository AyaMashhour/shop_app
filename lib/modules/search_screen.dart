import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/share/component/component.dart';
import 'package:shop_application/share/remote/layout/shop_layout_cubit.dart';
import 'package:shop_application/share/remote/layout/shop_layout_states.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
        create: (context) => ShopLayoutCubit(),
        child: BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                  appBar: AppBar(),
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: searchController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                labelText: 'Search',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 5.0),
                                )),
                            onFieldSubmitted: (String text) {
                              ShopLayoutCubit.get(context).getSearch(text);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'enter text to search';
                              }

                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          if (state is ShopLoadingSearchScreen)
                            LinearProgressIndicator(),

                          if (state is ShopSuccessSearchScreen)
                           
                            Expanded(
                              child: ListView.separated(

                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      buildListItems(
                                          ShopLayoutCubit.get(context)
                                              .model
                                              .data
                                              .data[index],
                                          context,isOldPrice: false),
                                  separatorBuilder: (context, index) =>
                                      Container(
                                        height: 1.0,
                                        color: Colors.grey[300],
                                      ),
                                  itemCount: ShopLayoutCubit.get(context)
                                      .model
                                      .data
                                      .data
                                      .length),
                            ),
                        ],
                      ),
                    ),
                  ));
            }));
  }
}
