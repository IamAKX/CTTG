import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomButton {
  static getButton(String s, BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
        child: Text(
          s,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ).tr(context: context),
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Colors.deepOrangeAccent, Colors.orangeAccent],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(80.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orangeAccent,
            blurRadius: 10.0,
            spreadRadius: 1,
            offset: Offset(3, 5),
          ),
        ],
      ),
    );
  }
}
