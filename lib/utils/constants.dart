import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kurdistan_food_network/routes/route_constants.dart';

// ========== ScreenSize ==========
double? kCurrentHeight;
double? kCurrentWidth;

// ========== Theme ==========
final kApplicationTheme = ThemeData(
  useMaterial3: true,
  primaryColor: kPrimaryColor,
  brightness: Brightness.light,
  textTheme: GoogleFonts.latoTextTheme(),
);

// ========== Colors ==========
const kBackgroundColor = Color(0xffF6FCEA);
const kPrimaryTextColor = Color(0xff262626);
const kPrimaryColor = Color.fromARGB(255, 55, 116, 45);
// const kSecondryColor = Color.fromARGB(255, 232, 240, 221);

// ========== Sizes ==========
const kPrimaryNavBarFontSize = 20.0;
const kPrimaryBorderRadiusValue = 10.0;
final kPrimaryBorderRadius = BorderRadius.circular(kPrimaryBorderRadiusValue);

// ========== Images ==========
const String kMapImage = 'assets/images/map';
const String kTomatoImage = 'assets/images/tomato';

// ========== Public Routes ==========
const List<String> publicRoutes = [
  '/',
  '/${RouteConstants.shop}',
  '/${RouteConstants.contact}',
  '/${RouteConstants.login}',
  '/${RouteConstants.register}'
];
