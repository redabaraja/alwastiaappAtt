import 'package:auto_size_text/auto_size_text.dart';
import 'package:alwastia/screens/student/homePage.dart';
import 'package:alwastia/screens/student/profile/profile.dart';
import 'package:alwastia/screens/teacher/homepage/homepage.dart';
import '../consts.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  late bool isStd;
  MainPage({required this.isStd});

  @override
  State<MainPage> createState() => _MainPageState(isStd: isStd);
}

class _MainPageState extends State<MainPage> {
  late bool isStd;
  _MainPageState({required this.isStd});
  List<Widget> classes = [HomePage(), Profile()];
  List<Widget> classes2 = [THomePage(), Profile()];

  int navbarstate = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: navbarstate == 0 ? navbar1() : navbar2(),
      body: isStd
          ? IndexedStack(
              index: navbarstate,
              children: classes,
            )
          : IndexedStack(
              index: navbarstate,
              children: classes2,
            ),
      // body: isStd ? classes[navbarstate] : classes2[navbarstate],
    ));
  }

  Container navbar2() {
    return Container(
      height: h * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100), topRight: Radius.circular(100)),
        color: blue,
      ),
      child: Row(
        children: [
          Spacer(),
          Container(
            height: h*0.065,
            width: w * 0.58,
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Row(
              children: [
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: Icon(
                    Icons.person,
                    size: f * 2,
                    color: blue,
                  )),
                ),
                Container(
                  width: w * 0.04,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: AutoSizeText(
                      'الصفحة الشخصية',
                      presetFontSizes: [f, f - f * 0.2, f - f * 0.4],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: blue,
                        fontFamily: 'DroidArabicKufi',
                        fontSize: f * 1.2,
                      ),
                    ),
                  ),
                ),
                Spacer()
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                navbarstate = 0;
              });
            },
            child: Container(
              width: w * 0.4,
              decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                      bottomLeft: Radius.circular(30),
                      topRight: Radius.circular(50))),
              child: Center(
                child: Container(
                    child: Icon(
                  Icons.home,
                  size: f * 1.7,
                  color: white,
                )),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container navbar1() {
    return Container(
      height: h * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100), topRight: Radius.circular(100)),
        color: blue,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                navbarstate = 1;
              });
            },
            child: Container(
              width: w * 0.4,
              decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Center(
                child: Container(
                    child: Icon(
                  Icons.person,
                  size: f * 1.7,
                  color: white,
                )),
              ),
            ),
          ),
          Container(
            height: h * 0.065,
            width: w * 0.58,
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(100))),
            child: Row(
              children: [
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: Icon(
                    Icons.home,
                    size: f * 2,
                    color: blue,
                  )),
                ),
                Container(
                  width: w * 0.04,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: AutoSizeText(
                      'الصفحة الرئيسية',
                      presetFontSizes: [f, f - f * 0.2, f - f * 0.4],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: blue,
                        fontFamily: 'DroidArabicKufi',
                        fontSize: f * 1.2,
                      ),
                    ),
                  ),
                ),
                Spacer()
              ],
            ),
          )
        ],
      ),
    );
  }

}
