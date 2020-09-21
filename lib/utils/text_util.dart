/*
  * Author: Gerald Addo-Tetteh
  * Book Search App
  * Text Util
*/

/*
  This class conatins font sizes and text styles
  used in this app.
*/

import 'package:flutter/material.dart';

import 'color_util.dart';

class TextUtil {
  TextUtil(this.mediaQuery);
  final MediaQueryData mediaQuery;

  double get textScale {
    return mediaQuery.textScaleFactor;
  }

  TextStyle get mainHeading {
    return TextStyle(
      foreground: Paint()..shader = ColorUtil.mainHeadingGradient,
      fontFamily: "CormorantGaramond",
      fontWeight: FontWeight.w700,
      fontSize: 40.0 * textScale,
    );
  }

  TextStyle get subHeading {
    return TextStyle(
      color: ColorUtil.white,
      fontSize: 12 * textScale,
      fontStyle: FontStyle.italic,
    );
  }

  TextStyle get buttonStyle {
    return TextStyle(
      color: ColorUtil.white,
      fontSize: 25.0 * textScale,
      fontStyle: FontStyle.italic,
    );
  }
}
