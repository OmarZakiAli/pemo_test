import 'dart:ui';

import 'package:flutter/material.dart';

class CardEntity {
  String cardName;
  String holderName;
  int balance;
  String color;
  int? id;
  Color get uiColor {
    List<String> colorValues = color.split(",");

    Color colorx = Color.from(
        alpha: double.parse(colorValues[0]) / 256,
        red: double.parse(colorValues[1]) / 256,
        green: double.parse(colorValues[2]) / 256,
        blue: double.parse(colorValues[3]) / 256);
    return colorx;
  }

  CardEntity({
    required this.cardName,
    required this.balance,
    required this.holderName,
    required this.color,
    this.id,
  });
}
