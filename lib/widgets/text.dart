import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/consts.dart';

Widget text(var text,
    {var fontSize = '18',
    textColor = Colors.black,
    var fontFamily = 'DroidArabicKufi',
    int textaligntype = 1, //0 for left , 1 for center , 2 for right
    int fontSizesLevel = 0,
    bool isBold = false,
    var maxLine = 1,
    var latterSpacing = 0.5}) {
  return AutoSizeText(text,
      textAlign: textaligntype == 0
          ? TextAlign.left
          : textaligntype == 1
              ? TextAlign.center
              : TextAlign.right,
      maxLines: maxLine,
      presetFontSizes: fontSizesLevel == -2
          ? [f - f * 0.4, f - f * 0.6]
          : fontSizesLevel == -1
              ? [f - f * 0.2, f - f * 0.4]
              : fontSizesLevel == 0
                  ? [f, f - f * 0.2, f - f * 0.4]
                  : fontSizesLevel == 1
                      ? [f * 1.2, f, f - f * 0.2, f - f * 0.4]
                      : [
                          f * 1.6,
                          f * 1.4,
                          f * 1.2,
                          f,
                          f - f * 0.2,
                          f - f * 0.4
                        ],
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textColor,
          height: 1.5,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          letterSpacing: latterSpacing));
}

Widget text2(var text,
    {var fontSize = '18',
    textColor = Colors.black,
    var fontFamily = 'DroidArabicKufi',
    int textaligntype = 1, //0 for left , 1 for center , 2 for right
    bool isBold = false,
    var maxLine = 1,
    var latterSpacing = 0.5}) {
  return Text(text,
      textAlign: textaligntype == 0
          ? TextAlign.left
          : textaligntype == 1
              ? TextAlign.center
              : TextAlign.right,
      maxLines: maxLine,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textColor,
          height: 1.5,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          letterSpacing: latterSpacing));
}
