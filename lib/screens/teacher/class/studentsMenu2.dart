import 'package:alwastia/bloc/teacher/getMyClassesBloc/model.dart';
import 'package:alwastia/consts.dart';
import 'package:alwastia/screens/teacher/attendanceSummry.dart';
import 'package:alwastia/screens/teacher/class/attendance.dart';
import 'package:alwastia/screens/teacher/class/marks.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/screens/teacher/class/attendance_summery.dart';
import 'package:alwastia/screens/teacher/class/exam.dart';
import 'package:alwastia/screens/teacher/class/lectures2.dart';
import 'package:alwastia/screens/teacher/class/noti.dart';
import 'package:alwastia/screens/teacher/class/students.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';

class StudentsMenu2 extends StatefulWidget {
  late ClassModel element;
  StudentsMenu2({required this.element});
  @override
  State<StudentsMenu2> createState() => _StudentsMenu2State(element: element);
}

class _StudentsMenu2State extends State<StudentsMenu2> {
  late ClassModel element;
  _StudentsMenu2State({required this.element});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: h * 0.13,
                width: w,
                child: Row(
                  children: <Widget>[
                    Spacer(),
                    InkWell(
                        onTap: () {
                          showCustomBottomSheet(
                              context, ClassStudents(element: element));
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (BuildContext context) =>
                          //         ClassStudents(element: element)));
                        },
                        child:
                            menuItem2('الطلاب', 'assets/images/stdicon.png')),
                    Spacer(),
                    InkWell(
                        onTap: () {
                          showCustomBottomSheet(
                              context, Marks(element: element));
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (BuildContext context) =>
                          //         Marks(element: element)));
                        },
                        child: menuItem2('الدرجات', 'assets/images/exam.png')),
                    Spacer()
                  ],
                ),
              ),
              Container(
                height: h * 0.03,
              ),
              Container(
                height: h * 0.13,
                width: w,
                child: Row(
                  children: <Widget>[
                    Spacer(),
                    InkWell(
                        onTap: () {
                          showCustomBottomSheet(
                              context,
                              AtdSummry(
                                element: element,
                              ));
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (BuildContext context) =>
                          //         AttendanceSumery(element: element)));
                        },
                        child: menuItem2('ملخص التحضير',
                            'assets/images/attendance-summery.png')),
                    Spacer(),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Lectures2(element: element)));
                        },
                        child: menuItem2(
                            'التحضير', 'assets/images/attendance.png')),
                    Spacer()
                  ],
                ),
              ),
              Container(
                height: h * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuItem2(String txt, String img) {
    return Container(
      height: h * 0.13,
      width: w * 0.4,
      decoration: boxDecoration(
        showShadow: true,
        radius: 10,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: h * 0.1,
              width: w * 0.4,
              decoration: boxDecoration(
                  imageExsit: true, imageAsset: img, boxfit: BoxFit.contain),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: h * 0.03,
              width: w * 0.4,
              decoration: BoxDecoration(
                  color: color3.withOpacity(0.3),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Center(
                child: text(txt,
                    fontSize: f,
                    fontSizesLevel: 0,
                    textColor: white,
                    isBold: true),
              ),
            ),
          ),
        ],
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

  void showCustomBottomSheet(BuildContext context, Widget widget) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return widget;
      },
    );
  }

  Container line() {
    return Container(
      height: 1,
      color: blue.withOpacity(0.2),
    );
  }
    FloatingActionButton floatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => Attendance(
                  element: element,
                  attendanceId: '',
                  isnew: true,
                  hours: '',
                )));
      },
      backgroundColor: blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      foregroundColor: white,
      icon: Icon(Icons.file_present),
      label: Text("تحضير جديد"),
    );
  }

}
