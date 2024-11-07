import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/register_screen.dart';
import 'package:shop_app/shared/natwork/cache_helper.dart';
import '../home_layout/shop_layout/shop_layout.dart';
import '../shared/component/component_login.dart';
import '../shared/constant.dart';
import '../shared/cubit/login/cubit_login.dart';
import '../shared/cubit/login/login_states.dart';
import '../shared/natwork/end_point.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isBassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {
        if (state is ShopLoginSuccessState) {
          if (state.loginModel.status) {
            CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data.token)!
                .then((value) {
            token=  state.loginModel.data.token;
              navigatorFinish(context, ShopLayoutScreen());
            });

            showToast(text: state.loginModel.message, state: ToastStates.SUCCESS);
          }
        }
      }, builder: (context, state) {
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
                        'LOGIN ',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text('Login now to browse our to hot offers',
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
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                            return null;
                          },
                          prefix: Icon(Icons.lock_open_outlined),
                          suffix: ShopLoginCubit.get(context).suffix,
                          suffixPressed: () {
                            ShopLoginCubit.get(context).changevisibility();
                          },
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          validater: (String? value) {
                            if (value!.isEmpty) return 'Password is too short ';
                            return null;
                          },
                          type: TextInputType.text),
                      SizedBox(
                        height: 20,
                      ),
                      state is! ShopLoginLoadingState
                          ? buttonOfLogin(
                        text: 'login',
                          onTap: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            })
                          : Center(child: CircularProgressIndicator(color: Colors.blueAccent,)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account? '),
                          //   Spacer(),
                          TextButton(
                              onPressed: () {
                                NavigatorTo(context, RegisterScreen());
                              },
                              child: Text(
                                'REGISTER ',
                                style: TextStyle(color: Colors.blue),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
