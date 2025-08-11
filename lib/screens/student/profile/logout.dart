import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/consts.dart';
import 'package:alwastia/screens/chose.dart';

class Logout extends StatefulWidget {
  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      logout();
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double fontx = width / 25;
    return Scaffold(
      backgroundColor: white,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: height * 0.17),
              height: height * 0.1,
              width: width * 0.4,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/logo.png"),
                      fit: BoxFit.contain)),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.1),
              height: height * 0.03,
              width: height * 0.03,
              child: CircularProgressIndicator(
                color: green,
                strokeWidth: 3,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.1),
              height: height * 0.1,
              child: Column(
                children: <Widget>[
                  // ignore: sized_box_for_whitespace
                  Container(
                      height: height * 0.05,
                      child: Center(
                          child: AutoSizeText("جاري تسجيل الخروج",
                              presetFontSizes: [
                                fontx,
                                fontx - fontx * 0.2,
                                fontx / 2,
                                fontx / 3
                              ],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'DroidArabicKufi',
                                  fontSize: fontx)))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  logout() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Chose()));
  }
}
