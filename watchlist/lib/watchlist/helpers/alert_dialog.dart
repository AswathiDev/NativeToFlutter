import 'package:flutter/material.dart';

class AlertDialogBox {
  

  static void showAlertDialogBox(BuildContext context, String title,String content) {
showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title:  Text(title),
              content:  Text(content),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // NavigationHelper.navigatePop(context);
                    },
                    child: const Text('Ok'))
              ],
            ));
  }}