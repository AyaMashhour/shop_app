import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/colors.dart';

Widget TextFromFeildShared(
        {required TextInputType type,
        Widget? prefix,
        IconData? suffix,
        String? label,
        Function? onTap,
        bool isPassword = false,
        Function? suffixPressed,
        String? Function(String? val)? onSubmit,
        required TextEditingController controller,
        String? Function(String? val)? validater}) =>
    TextFormField(
      keyboardType: type,
      onFieldSubmitted: (String? value) {
        onSubmit!(value);
      },
      cursorColor: defaultColor,
      scrollController: ScrollController(),

      decoration: InputDecoration(

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        errorStyle: TextStyle(
          fontSize: 15,
          color: Colors.red,

          //fontWeight: FontWeight.w200
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        labelText: label,
        focusColor: defaultColor,
        floatingLabelStyle: TextStyle(
            color: defaultColor,
            fontSize: 21,
            fontWeight: FontWeight.bold,
            fontFamily: 'hana'),
        labelStyle: TextStyle(
            fontSize: 18,

            //  fontWeight: FontWeight.w600,
            color: Colors.grey),
        prefixIcon: prefix,
        prefixIconColor: Colors.grey,
        suffixIcon: IconButton(
          icon: Icon(
            suffix,
          ),
          onPressed: () {
            suffixPressed!();
          },
        ),
        suffixIconColor: Colors.grey,
      ),
      obscureText: isPassword,
      onTap: () {
        onTap ?? ();
      },
      controller: controller,
      validator: (value) {
        return validater!(value);
      },


      //   obscureText: false,
    );

Widget buttonOfLogin({required Function onTap,required String text}) => Container(
      height: 53,
      width: double.infinity,
      child: TextButton(
          onPressed: () {
            onTap();
          },
          child: Text(
            text.toUpperCase(),
            style: TextStyle(color: Colors.white),
          )),
      decoration: BoxDecoration(
          color: Colors.blueAccent, borderRadius: BorderRadius.circular(15)),
    );

void showToast({required String ?text, required ToastStates state}) {
  Fluttertoast.showToast(
      msg: text??'',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}
