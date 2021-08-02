import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:shop_application/modules/register_screen.dart';
import 'package:shop_application/share/component/component.dart';
import 'package:shop_application/share/local/cache_helper.dart';
import 'package:shop_application/share/local/end_points.dart';
import 'package:shop_application/share/remote/login/shop_login_cubit.dart';
import 'package:shop_application/share/remote/login/shop_login_states.dart';

import 'package:shop_application/layout/layout_screen.dart';

class LoginScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var emailLogin = TextEditingController();
    var passwordLogin = TextEditingController();

    return BlocProvider(
        create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state)
        {

          if(state is ShopLoginSuccessState)
          {
            token=state.loginModel.data.token;
            if(state.loginModel.status){
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CacheHelper.saveData(key: 'token',
                  value:state.loginModel.data.token
              )
               .then((value)
               {
                 token=state.loginModel.data.token;
                 navigateAndFinish(context, LayoutScreen());
               });

            }else{

               flutterToast(text: state.loginModel.message,state: ToastStates.ERROR);

            }
          }

        },
        builder: (context,state){
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
                          'Login'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Text(
                          'Login now to browse our hot offer',
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        defaultTextFromField(
                        controller :emailLogin,
                          validatorText: 'Please Enter Your Email ',
                          icon: Icons.email,
                          labelText: 'Enter Your Email',
                          type: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFromField(
                            controller:  passwordLogin,
                            validatorText:  'Please Enter your Password',
                            icon: Icons.lock,
                            labelText: 'Enter your Password',
                            type: TextInputType.visiblePassword,
                            suffixIcon: Icons.remove_red_eye_outlined),
                        SizedBox(
                          height: 25.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context)=>
                              defaultBottom(
                                  function:()
                                  {
                              if(formKey.currentState.validate())
                                {
                              ShopLoginCubit.get(context).userLogin(
                                 email:   emailLogin.text,
                                password:  passwordLogin.text ,

                              );
                                }
                              }
                              ,text: 'login'
                            ),

                        fallback:(context)=>
                            Center(child: CircularProgressIndicator(),), ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account ?',

                                style: TextStyle(color: Colors.black)),
                            defaultTextBottom(text:'register',
                                function: () {
                                  navigateTo(context, RegisterScreen());
                                })
                          ],
                        )
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
