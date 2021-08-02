import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/share/component/component.dart';
import 'package:shop_application/share/remote/layout/shop_layout_cubit.dart';
import 'package:shop_application/share/remote/layout/shop_layout_states.dart';

class SettingsScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var nameTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var phoneTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context).profileModel.data;
        nameTextController.text = cubit.name;
        emailTextController.text = cubit.email;
        phoneTextController.text = cubit.phone;
        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).profileModel != null,
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateProfileScreen )
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 25.0,
                    ),
                    defaultTextFromField(
                      controller: nameTextController,
                      labelText: 'User Name',
                      icon: Icons.person,
                      validatorText: 'enter Your name',
                        type: TextInputType.name
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    defaultTextFromField(

                      controller: emailTextController,
                      labelText: ' Email',
                      icon: Icons.person,
                      validatorText: 'enter Your Email',
                        type: TextInputType.emailAddress
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    defaultTextFromField(
                      controller: phoneTextController,
                      labelText: ' Phone',
                      icon: Icons.person,
                      validatorText: 'enter Your phone',
                      type: TextInputType.phone
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    defaultBottom(
                        text: 'Update',
                        function: () {

                          if(formKey.currentState.validate())
                          ShopLayoutCubit.get(context).updateProfile(
                              name: nameTextController.text,
                              email: emailTextController.text,
                              phone: phoneTextController.text
                          );
                        }),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultBottom(
                        text: 'logout',
                        function: () {
                          signOut(context);
                        })
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  // Widget buildProfileData(context) =>
  //     SingleChildScrollView(
  //       child: Padding(
  //         padding: const EdgeInsets.all(15.0),
  //         child: Column(
  //           children: [
  //             if(state is ShopLoadingUpdateProfileScreen )
  //             LinearProgressIndicator(),
  //             SizedBox(
  //               height: 25.0,
  //             ),
  //             defaultTextFromField(
  //               controller: nameTextController,
  //               labelText: 'User Name',
  //               icon: Icons.person,
  //               validatorText: 'enter Your name',
  //             ),
  //             SizedBox(
  //               height: 25.0,
  //             ),
  //             defaultTextFromField(
  //               controller: emailTextController,
  //               labelText: ' Email',
  //               icon: Icons.person,
  //               validatorText: 'enter Your Email',
  //             ),
  //             SizedBox(
  //               height: 25.0,
  //             ),
  //             defaultTextFromField(
  //               controller: phoneTextController,
  //               labelText: ' Phone',
  //               icon: Icons.person,
  //               validatorText: 'enter Your phone',
  //             ),
  //             SizedBox(
  //               height: 25.0,
  //             ),
  //             defaultBottom(
  //                 text: 'Update',
  //                 function: () {
  //                   ShopLayoutCubit.get(context).updateProfile(
  //                       name: nameTextController.text,
  //                       email: emailTextController.text,
  //                       phone: phoneTextController.text);
  //                 }),
  //             SizedBox(
  //               height: 25.0,
  //             ),
  //             defaultBottom(
  //                 text: 'logout',
  //                 function: () {
  //                   signOut(context);
  //                 })
  //           ],
  //         ),
  //       ),
  //     );
}
