import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/shared/cubit/shop/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop/shop_states.dart';

import '../../shared/component/component_login.dart';
import '../../shared/constant.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).shopLoginModel;

        emailController.text = model?.data.email!??'';
        phoneController.text = model?.data.phone!??'';
        nameController.text = model?.data.name!??'';
        return ConditionalBuilder(
          condition: model!=null,
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpDateUserDataState)
                      LinearProgressIndicator(
                        color: Colors.blueAccent,
                      ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFromFeildShared(
                      controller: nameController,
                      type: TextInputType.name,
                      label: 'Name',
                      prefix: Icon(Icons.person),
                      validater: (String? value) {
                        if (value!.isEmpty) {
                          return 'please Add Your Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFromFeildShared(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      label: 'Email Address',
                      prefix: Icon(Icons.email),
                      validater: (String? value) {
                        if (value!.isEmpty) {
                          return 'please Add Your Email';
                        }
                        return null;

                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFromFeildShared(
                      controller: phoneController,
                      type: TextInputType.phone,
                      label: 'Phone',
                      prefix: Icon(Icons.phone),
                      validater: (String? value) {
                        if (value!.isEmpty) {
                          return 'please Add Your Phone';
                        }
                        return null;

                      },
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    buttonOfLogin(
                        text: ' update ',
                        onTap: () {
                           if(formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateProfileData(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text);
                        }}),
                    SizedBox(
                      height: 20.0,
                    ),
                    buttonOfLogin(
                        text: ' logout ',
                        onTap: () {
                          signOut(context, LoginScreen());
                        })
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(
              color: Colors.blueAccent,
            ),
          ),
        );
      },
    );
  }
}
