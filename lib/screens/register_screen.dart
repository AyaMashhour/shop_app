import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/login/login_states.dart';

import '../home_layout/shop_layout/shop_layout.dart';
import '../shared/component/component_login.dart';
import '../shared/constant.dart';
import '../shared/cubit/login/cubit_login.dart';
import '../shared/cubit/register/register_cubit.dart';
import '../shared/cubit/register/register_state.dart';
import '../shared/natwork/cache_helper.dart';
import '../shared/natwork/end_point.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status) {
              CacheHelper.saveData(
                  key: 'token', value: state.loginModel.data.token)!
                  .then((value) {
                token=  state.loginModel.data.token;
                navigatorFinish(context, ShopLayoutScreen());
              });

              showToast(text: state.loginModel.message, state: ToastStates.SUCCESS);
            }
          }        },
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
                          'REGISTER ',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Register now to browse our to hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.grey)),
                        SizedBox(
                          height: 20,
                        ),
                        TextFromFeildShared(
                            validater: (String? value) {
                              if (value!.isEmpty)
                                return 'Please enter your Name';
                              return null;
                            },
                            prefix: Icon(Icons.person),
                            controller: nameController,
                            label: 'Name',
                            type: TextInputType.name),
                        SizedBox(
                          height: 20,
                        ),
                        TextFromFeildShared(
                            validater: (String? value) {
                              if (value!.isEmpty)
                                return 'Please enter your phone';
                              return null;
                            },
                            prefix: Icon(Icons.phone),
                            controller: phoneController,
                            label: 'Phone',
                            type: TextInputType.phone),
                        SizedBox(
                          height: 20,
                        ),
                        TextFromFeildShared(
                            validater: (String? value) {
                              if (value!.isEmpty)
                                return 'Please enter your email';
                              return null;
                            },
                            prefix: Icon(Icons.email_outlined),
                            controller: emailController,
                            label: 'Email Address',
                            type: TextInputType.emailAddress),
                        SizedBox(
                          height: 20,
                        ),
                        TextFromFeildShared(
                            controller: passwordController,
                            label: 'Password',
                            prefix: Icon(Icons.lock_open_outlined),
                            suffix: ShopRegisterCubit.get(context).suffix,
                            suffixPressed: () {
                              ShopRegisterCubit.get(context).changevisibility();
                            },
                            isPassword: ShopRegisterCubit.get(context).isPassword,
                            validater: (String? value) {
                              if (value!.isEmpty)
                                return 'Password is too short ';
                              return null;
                            },
                            type: TextInputType.text),
                        SizedBox(
                          height: 20,
                        ),
                        state is !ShopRegisterLoadingState
                            ? buttonOfLogin(
                          text: 'register',
                            onTap: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text);
                                }
                              })
                            : Center(
                                child: CircularProgressIndicator(
                                color: Colors.blueAccent,
                              )),
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
