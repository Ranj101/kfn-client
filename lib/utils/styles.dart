import 'package:flutter/material.dart';
import 'package:kurdistan_food_network/utils/constants.dart';

ButtonStyle elevatedButtonStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(0),
  backgroundColor: MaterialStateProperty.all(kPrimaryColor),
  shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: kPrimaryBorderRadius)),
  minimumSize: MaterialStateProperty.all(const Size(100, 55)),
);

ButtonStyle shoppingBagButtonStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(0),
  backgroundColor: MaterialStateProperty.all(kBackgroundColor),
  shape: MaterialStateProperty.all(RoundedRectangleBorder(
    borderRadius: kPrimaryBorderRadius,
    side: const BorderSide(color: Color.fromARGB(255, 199, 206, 190)),
  )),
  minimumSize: MaterialStateProperty.all(const Size(100, 55)),
);
