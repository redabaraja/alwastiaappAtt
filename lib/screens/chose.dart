import 'dart:io';

import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/screens/mainPage.dart';
import 'package:alwastia/screens/student/login.dart';
import 'package:alwastia/screens/teacher/login.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';

import '../consts.dart';
import 'package:flutter/material.dart';

class Chose extends StatefulWidget {
  const Chose({Key? key}) : super(key: key);

  @override
  State<Chose> createState() => _ChoseState();
}

class _ChoseState extends State<Chose> {
  LocalData hive = new LocalData();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else {
          exit(0);
        }

        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: white,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // image
                Container(
                  height: h * 0.28-5,
                  width: w,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: h * 0.25,
                      width: w * 0.4,
                      decoration: boxDecoration(
                          imageExsit: true,
                          imageAsset: "assets/images/logo.png",
                          boxfit: BoxFit.contain),
                    ),
                  ),
                ),
                // text
                Container(
                  // height: h * 0.2,
                  width: w,
                  child: Column(
                    children: [
                      Container(
                        width: w,
                        child: Center(
                          child: text("مرحبا بكم في تطبيق منصة التعليم الإلكتروني",
                              textColor: color3,
                              fontSize: f,
                              fontSizesLevel: 1,
                              isBold: true),
                        ),
                      ),
                      Container(
                        width: w,
                        child: Center(
                          child: text("تطبيق يخلق حلقة تواصل",
                              textColor: color3,
                              fontSize: f,
                              fontSizesLevel: 1,
                              isBold: true),
                        ),
                      ),
                      Container(
                        width: w,
                        child: Center(
                          child: text("بين المعلم وطلابة",
                              textColor: color3,
                              fontSize: f,
                              fontSizesLevel: 1,
                              isBold: true),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: h * 0.04,
                ),
                InkWell(
                  onTap: () {
                    // checkIfItLogin();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => TeacherLogin(isStd: true,)));
                  },
                  child: Container(
                    height: h * 0.07,
                    width: w * 0.7,
                    decoration: boxDecoration(
                        bgColor: green, showShadow: true, radius: 5),
                    child: Center(
                      child: text('الدخول كطالب',
                          fontSize: f,
                          fontSizesLevel: 1,
                          isBold: true,
                          textColor: white),
                    ),
                  ),
                ),
                Container(
                  height: h * 0.02,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => TeacherLogin(isStd: false,)));
                  },
                  child: Container(
                    height: h * 0.07,
                    width: w * 0.7,
                    decoration:
                        boxDecoration(bgColor: blue, showShadow: true, radius: 5),
                    child: Center(
                      child: text('الدخول كمعلم',
                          fontSize: f,
                          fontSizesLevel: 1,
                          isBold: true,
                          textColor: white),
                    ),
                  ),
                ),
                Container(
                  height: h * 0.39,
                  width: w,
                  decoration: boxDecoration(
                      imageExsit: true,
                      imageAsset: 'assets/images/chose.png',
                      boxfit: BoxFit.cover),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkIfItLogin() async {
    await hive.openBox();
    if (await hive.userBox.isEmpty) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => StdLogin()));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => MainPage(
                isStd: true,
              )));
    }
  }
}
