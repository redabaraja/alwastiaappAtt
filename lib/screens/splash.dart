import 'dart:async';
import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';
import 'package:alwastia/bloc/student/profileBloc/localdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/consts.dart';
import 'package:alwastia/screens/chose.dart';
import 'package:alwastia/screens/student/class/classroom.dart';
import 'package:alwastia/screens/mainPage.dart';

class AppSplashScreen extends StatefulWidget {
  static String tag = '/ProkitSplashScreen';

  @override
  _AppSplashScreenState createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen>
    with SingleTickerProviderStateMixin {
  LocalData hive = new LocalData();
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      checkIfItLogin();
    });
  }

  Widget build(BuildContext context) {
    initlengthAndWith(context);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double f = w / 25;
    return Scaffold(
      backgroundColor: white,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: h * 0.27),
            alignment: Alignment.center,
            child: Image.asset('assets/images/logo.png',
                height: 200, fit: BoxFit.fitHeight),
          ),
          Container(
            height: h * 0.03,
          ),
          Container(
            width: w,
            child: Center(
              child: Text("جامعة الوسطية ",
                  style: TextStyle(
                      color: color3,
                      fontWeight: FontWeight.bold,
                      fontSize: f + f * 0.4)),
            ),
          ),
          Container(
            height: h * 0.25,
          ),
          Container(
            child: Image.asset(
              "assets/images/loader.gif",
              height: h * 0.1,
              width: w * 0.7,
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }

  void checkIfItLogin() async {
    await hive.openBox();
    // LocalUserInfo h = LocalUserInfo();
    // await h.openBox();
    // await h.userinfoBox.clear();
    // await h.userinfoBox.close();
    // await hive.userBox.clear();
    if (await hive.userBox.isEmpty) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Chose()));
    } else {
      String type = await hive.getType();
      if (type == 'الطلاب') {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => ClassRoom(
                  element: ClassModel2(
                      id: 1,
                      name: 'رضا',
                      credit: 1,
                      image: '',
                      teacher: 'سالم',
                      stdCount: 12),
                )));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MainPage(
                  isStd: type == 'الطلاب',
                )));
      }
    }
  }
}
