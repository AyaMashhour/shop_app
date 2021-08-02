import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_application/models/boarding_model.dart';
import 'package:shop_application/modules/login_screen.dart';
import 'package:shop_application/share/local/cache_helper.dart';
import 'package:shop_application/share/remote/layout/shop_layout_cubit.dart';

void navigateTo(context, Widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));
}

void navigateAndFinish(context, Widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => Widget),
        (Route<dynamic> route) => false,
  );
}

bool isUpperCase = true;

Widget defaultBottom({
  String text,
  Function function,
}) =>
    Container(
      height: 55.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue,
      ),
      width: double.infinity,
      child: TextButton(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          onPressed: function,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          )),
    );

Widget buildBoardingItem(BoardingModel model) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 400,
            child: Center(child: Image(image: AssetImage('${model.image}')))),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 28),
          child: Text(
              '${model.textTitle}', style: TextStyle(color: Colors.black)),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 28),
          child: Text('${model.textBody}'),
        ),
      ],
    );


Widget defaultTextFromField({
   @required TextEditingController controller,
    @required  String validatorText,
  @required IconData icon,
  @required String labelText,
  @required   TextInputType type,

      IconData suffixIcon,
    }) =>
    TextFormField(
      controller: controller,
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty) {
          return validatorText;
        }
      },
      keyboardType: type,
      decoration: InputDecoration(
          suffixIcon: Icon(suffixIcon),
          prefixIcon: Icon(icon),
          labelText: labelText,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 5.0),
          )),
    );

Widget defaultTextBottom
    ({String text, Function function}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase(), style: TextStyle(color: Colors.blue)),

    );


Widget flutterToast({String text ,ToastStates state}){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 18.0
  );
}

enum ToastStates{SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;
  switch (state){
    case ToastStates.SUCCESS:
      color=Colors.green;
      break;
    case ToastStates.WARNING:
      color=Colors.amber;
      break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;
  }
   return color;
}


void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value)
  {
    navigateAndFinish(context, LoginScreen());
  });
}

Widget buildListItems(model, context,{bool isOldPrice=true})=>Padding(
  padding: const EdgeInsets.all(12.0),
  child: Container(
    height: 120.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Container(
              child: Image(
                image: NetworkImage(
                    '${model.image}'),
                height: 115.0,
                width: 125.0,

              ),
            ),
            if (model.discount != 0 &&isOldPrice )
              Container(

                padding: EdgeInsets.symmetric(horizontal: 7),
                color: Colors.red,
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(fontSize: 12.0, color: Colors.white),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15.0),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(fontSize: 16.0, color: Colors.blue),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (model.discount != 0 &&isOldPrice)
                    Text(
                      '${model.oldPrice}',
                      style: TextStyle(
                          fontSize: 13.5,
                          color: Colors.grey[500],
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      ShopLayoutCubit.get(context)
                          .changeFavorites(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: ShopLayoutCubit.
                      get(context).favorites[model.id]!=null?
                      Colors.blue
                          :Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 17.0,
                      ),

                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  ),
);


Color defaultColor=Colors.blue;
