/*
  * Author: Gerald Addo-Tetteh
  * Book Search App
  * Color Util
*/

/*
  This class contains colors and gradients used 
  in the app.
*/

import 'package:flutter/material.dart';

class ColorUtil {
  static const white = Color(0xfff7f7f7);
  static const dark = Color(0xff212121);
  static const silverWhite = Color(0xfff8f8f8);
  static const buttonColor = Color(0xff45b4ff);
  static const searchPageGradient = LinearGradient(
    colors: [
      Color(0xffabb2b8),
      Color(0xff425262),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const resultPageGradient = LinearGradient(
    colors: [
      Color(0xffa3d8eb),
      Color(0xff719ec2),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const detailPageGradient = LinearGradient(
    colors: [
      Color(0xff395d7d),
      Color(0xffc06c84),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static final mainHeadingGradient =
      resultPageGradient.createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
}
