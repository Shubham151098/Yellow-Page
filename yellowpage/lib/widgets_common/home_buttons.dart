import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yellowpage/consts/colors.dart';
// import 'package:yellowpage/consts/consts.dart';

Widget homeButtons({width, height, icon, String? title, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 26,
      ),
      10.heightBox,
      title!.text.fontFamily('poppins').color(darkFontGrey).make()
    ],
  ).box.rounded.white.size(width, height).make();
}
