import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomText {
  static Widget getHeaderText(String text, BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.w800,
      ),
    ).tr(context: context);
  }
}
