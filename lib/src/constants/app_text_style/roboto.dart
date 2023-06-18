// ignore_for_file: prefer_const_constructors

import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin AppStyleRoboto {
  static TextStyle kFontW4 = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    color: kBlack,
    fontSize: 20,
  );

  static TextStyle kFontW5 = GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    color: kBlack,
    fontSize: 20,
  );

  static TextStyle kFontW6 = GoogleFonts.roboto(
    color: kBlack,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static TextStyle kFontW7 = GoogleFonts.roboto(
    color: kBlack,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
}
