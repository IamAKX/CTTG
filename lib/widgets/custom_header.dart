import 'package:cttgfahrer/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHeader {
  static Widget getMainHeader(String key, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomText.getHeaderText(key, context),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 50,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.orange, borderRadius: BorderRadius.circular(5)),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  static getSubHeader(String s, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          s,
          style: GoogleFonts.roboto(
            color: Color.fromARGB(255, 96, 96, 96),
            fontSize: 16,
          ),
        ).tr(context: context),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
