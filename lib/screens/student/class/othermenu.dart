import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/screens/student/class/exam.dart';
import 'package:alwastia/screens/student/class/lectures2.dart';
import 'package:alwastia/screens/student/class/noti.dart';
import 'package:alwastia/widgets/text.dart';

class OthersMenu extends StatefulWidget {
  late ClassModel2 element;
  OthersMenu({required this.element});
  @override
  State<OthersMenu> createState() => _OthersMenuState(element: element);
}

class _OthersMenuState extends State<OthersMenu> {
  late ClassModel2 element;
  _OthersMenuState({required this.element});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Exam(element: element)));
                  },
                  child: menuItem('الإمتحانات')),
              line(),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Noti2(element: element)));
                  },
                  child: menuItem('الإشعارات')),
              line(),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Lectures2(element: element)));
                  },
                  child: menuItem('الحضور والغياب')),
            ],
          ),
        ),
      ),
    );
  }

  Container menuItem(String name) {
    return Container(
      height: h * 0.05,
      width: w,
      child: Row(
        children: <Widget>[
          Container(
            width: w * 0.15,
          ),
          Icon(
            Icons.arrow_back_ios,
            size: f,
            color: blue,
          ),
          Spacer(),
          Container(
            height: h * 0.07,
            child: Center(
              child:
                  text(name, fontSize: f, fontSizesLevel: 0, textColor: blue),
            ),
          ),
          Container(
            width: w * 0.1,
          ),
        ],
      ),
    );
  }

  Container line() {
    return Container(
      height: 1,
      color: blue.withOpacity(0.2),
    );
  }
}
