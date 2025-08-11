import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';
import 'package:alwastia/bloc/student/getStdMarks/bloc.dart';
import 'package:alwastia/bloc/student/getStdMarks/event.dart';
import 'package:alwastia/bloc/student/getStdMarks/state.dart';
import 'package:alwastia/consts.dart';
import 'package:alwastia/screens/student/class/stdAttendance.dart';
import 'package:alwastia/screens/student/class/stdMarks.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/screens/student/class/exam.dart';
import 'package:alwastia/screens/student/class/homework.dart';
import 'package:alwastia/screens/student/class/noti.dart';
import 'package:alwastia/screens/student/class/oneStudentattendance.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherMenu2 extends StatefulWidget {
  late ClassModel2 element;
  OtherMenu2({required this.element});
  @override
  State<OtherMenu2> createState() => _OtherMenu2State(element: element);
}

class _OtherMenu2State extends State<OtherMenu2> {
  late ClassModel2 element;
  _OtherMenu2State({required this.element});
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetStdMarksBloc>(context).add(GetMarks());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BlocBuilder<GetStdMarksBloc, GetStdMarksState>(
                  builder: (context, state) {
                if (state is LoadingState) {
                  return Container(
                    height: h * 0.3,
                    width: w,
                    child: Center(
                      child: Container(
                        height: h * 0.03,
                        width: h * 0.03,
                        child: CircularProgressIndicator(
                          color: blue,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  );
                } else if (state is GetMarksDone) {
                  if (state.connection) {
                    return Column(
                      children: [
                        Container(
                          height: h * 0.07,
                          width: w * 0.975,
                          decoration:
                              boxDecoration(bgColor: blue.withOpacity(0.8)),
                          child: Row(
                            children: [
                              Container(
                                height: h * 0.1,
                                width: w * 0.67,
                                child: Row(
                                  children: [
                                    Container(
                                      height: h * 0.1,
                                      width: w * 0.16,
                                      child: Column(
                                        children: [
                                          Spacer(),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            child: text('الفصلي',
                                                fontSize: f,
                                                fontSizesLevel: -1,
                                                isBold: true,
                                                textColor: white),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: h * 0.09,
                                      width: 1,
                                      color: white,
                                    ),
                                    Container(
                                      height: h * 0.1,
                                      width: w * 0.24,
                                      child: Column(
                                        children: [
                                          Spacer(),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            child: text('الشهر الثاني',
                                                fontSize: f,
                                                fontSizesLevel: -1,
                                                isBold: true,
                                                textColor: white),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: h * 0.09,
                                      width: 1,
                                      color: white,
                                    ),
                                    Container(
                                      height: h * 0.1,
                                      width: w * 0.24,
                                      child: Column(
                                        children: [
                                          Spacer(),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            child: text('الشهر الاول',
                                                fontSize: f,
                                                fontSizesLevel: -1,
                                                isBold: true,
                                                textColor: white),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: h * 0.09,
                                      width: 1,
                                      color: white,
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                  height: h * 0.1,
                                  width: w * 0.2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          bottomRight: Radius.circular(15))),
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Text(
                                          'المواد',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: white,
                                              fontSize: f,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  )),
                              Container(
                                  height: h * 0.1,
                                  // width: w * 0.1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          bottomRight: Radius.circular(15))),
                                  child: Stack(
                                    children: [
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 5, right: 5),
                                            child: Icon(
                                              Icons.book,
                                              color: white,
                                              size: f * 1.5,
                                            ),
                                          ))
                                    ],
                                  )),
                              Container(
                                width: 4,
                              )
                            ],
                          ),
                        ),
                        ListView.builder(
                          itemCount: state.data.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: h * 0.1,
                              width: w * 0.95,
                              margin: EdgeInsets.only(left: 5, right: 5),
                              decoration:
                                  boxDecoration(showShadow: false, color: blue),
                              child: Row(
                                children: [
                                  Container(
                                    height: h * 0.1,
                                    width: w * 0.67,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: h * 0.1,
                                          width: w * 0.16,
                                          child: Column(
                                            children: [
                                              Spacer(),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                // decoration: boxDecoration(
                                                //     radius: 5,
                                                //     showShadow: true,
                                                //     bgColor: blue.withOpacity(0.8)),
                                                child: text(
                                                    state.data[index].results
                                                            .isEmpty
                                                        ? '0'
                                                        : state
                                                            .data[index]
                                                            .results[0]
                                                            .degreeOfFinalTheory
                                                            .toString(),
                                                    fontSize: f,
                                                    fontSizesLevel: -1,
                                                    isBold: true,
                                                    textColor: Colors.black),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: h * 0.09,
                                          width: 1,
                                          color: blue,
                                        ),
                                        Container(
                                          height: h * 0.1,
                                          width: w * 0.24,
                                          child: Column(
                                            children: [
                                              Spacer(),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                // decoration: boxDecoration(
                                                //     radius: 5,
                                                //     showShadow: true,
                                                //     bgColor: blue.withOpacity(0.8)),
                                                child: text(
                                                    state.data[index].results
                                                            .isEmpty
                                                        ? '0'
                                                        : state
                                                            .data[index]
                                                            .results[0]
                                                            .secondMonthTheory
                                                            .toString(),
                                                    fontSize: f,
                                                    fontSizesLevel: -1,
                                                    isBold: true,
                                                    textColor: Colors.black),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: h * 0.09,
                                          width: 1,
                                          color: blue,
                                        ),
                                        Container(
                                          height: h * 0.1,
                                          width: w * 0.24,
                                          child: Column(
                                            children: [
                                              Spacer(),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                // decoration: boxDecoration(
                                                //     radius: 5,
                                                //     showShadow: true,
                                                //     bgColor: blue.withOpacity(0.8)),
                                                child: text(
                                                    state.data[index].results
                                                            .isEmpty
                                                        ? '0'
                                                        : state
                                                            .data[index]
                                                            .results[0]
                                                            .firstMonthTheory
                                                            .toString(),
                                                    fontSize: f,
                                                    fontSizesLevel: -1,
                                                    isBold: true,
                                                    textColor: Colors.black),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: h * 0.09,
                                          width: 1,
                                          color: blue,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Spacer(),
                                  Expanded(
                                    child: Container(
                                        height: h * 0.1,
                                        // width: w * 0.2,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15))),
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Text(
                                                state.data[index].subject,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: blue,
                                                    fontSize: f * 0.7,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                  Container(
                                      height: h * 0.1,
                                      // width: w * 0.1,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              bottomRight:
                                                  Radius.circular(15))),
                                      child: Stack(
                                        children: [
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 5, right: 5),
                                                child: Icon(
                                                  Icons.book,
                                                  color: blue,
                                                  size: f * 1,
                                                ),
                                              ))
                                        ],
                                      )),
                                  Container(
                                    width: 4,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      height: h * 0.3,
                      width: w,
                      child: Center(
                          child: text('لا يوجد اتصال بالانترنت',
                              fontSize: f, fontSizesLevel: 0)),
                    );
                  }
                } else {
                  return Container();
                }
              }),
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

  Container line() {
    return Container(
      height: 1,
      color: blue.withOpacity(0.2),
    );
  }
}
