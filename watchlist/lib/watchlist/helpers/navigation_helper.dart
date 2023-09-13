import 'package:flutter/material.dart';

class NavigationHelper {
  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => screen));
  }

  static void closeCurrentScreen(BuildContext context){
    Navigator.of(context).pop();
  }

  static Future navigateToScreenWithArgs(
      BuildContext context, Widget screen) async {
    final result =
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => screen));
    return result;
  }
}
