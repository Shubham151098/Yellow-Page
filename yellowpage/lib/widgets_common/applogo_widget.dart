import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
// import 'package:yellowpage/consts/consts.dart';
import 'package:yellowpage/consts/images.dart';

Widget applogoWidget() {
  // using velocity x
  return Image.asset(icLogo)
      .box
      .white
      .size(77, 77)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}
