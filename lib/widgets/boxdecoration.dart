import 'dart:io';

import 'package:flutter/material.dart';
import 'package:alwastia/consts.dart';

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color bgColor = white,
    int colorType = 0, //0 for one color 1 for gradient color
    Color color1 = white,
    Color color2 = white,
    var showShadow = false,
    var imageExsit = false,
    int imagetype = 0,// 0 for asset 1 for network 2 for file
    String imageAsset = '',
    String imageUrl = '',
    String imagepath = '',
    Alignment gradientBegin = Alignment.topLeft,
    Alignment gradientEnd = Alignment.bottomRight,
    BoxFit boxfit = BoxFit.contain}) {
  return BoxDecoration(
      //gradient: LinearGradient(colors: [bgColor, whiteColor]),
      color: colorType == 0 ? bgColor : white,
      gradient: colorType == 0
          ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                  bgColor,
                  bgColor,
                ])
          : LinearGradient(begin: gradientBegin, end: gradientEnd, colors: [
              color1,
              color2,
            ]),
      image: imageExsit
          ? imagetype == 0
              ? DecorationImage(image: AssetImage(imageAsset), fit: boxfit)
              : imagetype == 1
                  ? DecorationImage(image: NetworkImage(imageUrl), fit: boxfit)
                  : imagetype == 2
                      ? DecorationImage(
                          image: FileImage(
                            File(imagepath),
                          ),
                          fit: boxfit)
                      : DecorationImage(image: AssetImage(''))
          : null,
      boxShadow: showShadow
          ? [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 4)
            ]
          : [BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}
