import 'package:flutter/material.dart';

import 'natwork/cache_helper.dart';

void navigatorFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false);

void NavigatorTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void signOut(context, widget) {
  CacheHelper.clearData(key: 'token')?.then((value) {
    navigatorFinish(context, widget);
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1.800}');
  pattern.allMatches(text).forEach((match)
  => print(match.group(0)));
}
