import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/component/list_shared.dart';
import 'package:shop_app/shared/cubit/search/search_state.dart';

import '../../shared/component/component_login.dart';
import '../../shared/cubit/search/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFromFeildShared(
                      label: ' Salla Search',
                      prefix: Icon(Icons.search),
                      onSubmit: (String? text) {
                        SearchCubit.get(context).searchData(text!);
                      },
                      type: TextInputType.text,
                      controller: searchController),
                  SizedBox(
                    height: 10,
                  ),
                  if (state is SearchLoadingState)
                    LinearProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildListProduct(
                            SearchCubit.get(context)
                                .searchModel!
                                .data!
                                .data![index],
                            context,isOldPrice: false),
                        separatorBuilder: (context, index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.grey[300]),
                        itemCount: SearchCubit.get(context)
                            .searchModel!
                            .data!
                            .data!
                            .length,
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
