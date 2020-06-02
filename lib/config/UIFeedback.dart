import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UIFeedback {
  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.orangeAccent.withOpacity(0.3),
        textColor: Colors.deepOrange,
        fontSize: 14.0);
  }
}
