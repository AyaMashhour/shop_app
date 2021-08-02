import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:shop_application/modules/register_screen.dart';
import 'package:shop_application/share/component/component.dart';
import 'package:shop_application/share/local/cache_helper.dart';
import 'package:shop_application/share/local/end_points.dart';
import 'package:shop_application/share/remote/login/shop_login_cubit.dart';
import 'package:shop_application/share/remote/register/shop_register_cubit.dart';
import 'package:shop_application/share/remote/register/shop_register_states.dart';
import 'package:shop_application/layout/layout_screen.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameRegister = TextEditingController();
  var emailRegister = TextEditingController();
  var passwordRegister = TextEditingController();
  var phoneRegister = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                token = state.loginModel.data.token;
                navigateAndFinish(context, LayoutScreen());
              });
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Text(
                          'Register now to browse our hot offer',
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        defaultTextFromField(
                          controller: nameRegister,
                          validatorText: 'Please Enter Your name ',
                          icon: Icons.person,
                          labelText: 'Enter Your name',
                          type: TextInputType.name,
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        defaultTextFromField(
                          controller: emailRegister,
                          validatorText: 'Please Enter Your Email ',
                          icon: Icons.email,
                          labelText: 'Enter Your Email',
                          type: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFromField(
                            controller: passwordRegister,
                            validatorText: 'Please Enter your Password',
                            icon: Icons.lock,
                            labelText: 'Enter your Password',
                            type: TextInputType.visiblePassword,

                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFromField(
                          controller: phoneRegister,
                          validatorText: 'Please Enter your phone',
                          icon: Icons.phone,
                          labelText: 'Enter your phone',
                          type: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultBottom(
                              function: () {
                                if (formKey.currentState.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                    name: nameRegister.text,
                                    phone: phoneRegister.text,
                                    email: emailRegister.text,
                                    password: passwordRegister.text,
                                  );
                                }
                              },
                              text: 'Register'),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
