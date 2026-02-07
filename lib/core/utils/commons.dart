import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastStates { success, error, warning }

extension ShowToastMsg on BuildContext {
  void showToastMsg({required String msg, required ToastStates toastState}) {
    Color color;
    switch (toastState) {
      case ToastStates.success:
        color = Color(0xff3369FF);
        break;
      case ToastStates.warning:
        color = Colors.amber;
        break;
      case ToastStates.error:
        color = Colors.red;
        break;
    }
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
