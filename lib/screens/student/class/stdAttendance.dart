import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';
import 'package:alwastia/bloc/teacher/getAttendanceSumery.dart/bloc.dart';
import 'package:alwastia/bloc/teacher/getAttendanceSumery.dart/event.dart';
import 'package:alwastia/bloc/teacher/getAttendanceSumery.dart/state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';

class StdAttendance extends StatefulWidget {
  late ClassModel2 element;
  StdAttendance({required this.element});
  @override
  State<StdAttendance> createState() => _StdAttendanceState(element: element);
}

class _StdAttendanceState extends State<StdAttendance> {
  late ClassModel2 element;
  _StdAttendanceState({required this.element});
  var titleController = TextEditingController();
  var markController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AttendanceSummeryBloc>(context)
        .add(GetOneAttendanceSummery(classId: element.id));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocListener<AttendanceSummeryBloc, AttendanceSummeryState>(
      listener: (context, state) => {
        // if (state is MyOneAttendanceSummery)
        //   {
        //     BlocProvider.of<AttendanceSummeryBloc>(context)
        //         .add(GetAttendanceDetails(classId: element.id))
        //   }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: h * 0.04,
                  width: w,
                  margin: EdgeInsets.only(top: 5, right: 5),
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        size: f * 1.3,
                        color: blue,
                      ))),
              Container(
                height: h * 0.05,
                width: w,
                margin: EdgeInsets.only(top: 5, right: 5),
                alignment: Alignment.centerRight,
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: text('المادة :  ${element.name}',
                        fontSize: f,
                        fontSizesLevel: 0,
                        textColor: color3,
                        isBold: true)),
              ),
              Container(
                height: h * 0.05,
                width: w,
                margin: EdgeInsets.only(top: 5, right: 5),
                alignment: Alignment.centerRight,
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: text('المدرس : ${element.teacher}',
                        fontSize: f,
                        fontSizesLevel: 0,
                        textColor: color3,
                        isBold: true)),
              ),
              Container(
                height: h * 0.1,
                width: w,
                child: Center(
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: text('ملخص التحضير',
                          fontSize: f,
                          fontSizesLevel: 1,
                          textColor: color3,
                          isBold: true)),
                ),
              ),
              BlocBuilder<AttendanceSummeryBloc, AttendanceSummeryState>(
                  builder: (context, state) {
                if (state is LoadingState) {
                  return Container(
                    height: h * 0.15,
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
                } else if (state is MyOneAttendanceSummery) {
                  if (state.connection) {
                    print('it is connected');
                    return Column(
                      children: [
                        Container(
                          height: h * 0.07,
                          width: w * 0.975,
                          decoration:
                              boxDecoration(bgColor: blue.withOpacity(0.8)),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: h * 0.1,
                                  // width: w * 0.6,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: h * 0.1,
                                          // width: w * 0.24,
                                          child: Column(
                                            children: [
                                              Spacer(),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                child: text('اجمالي الغياب',
                                                    fontSize: f,
                                                    fontSizesLevel: -1,
                                                    isBold: true,
                                                    textColor: white),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: h * 0.09,
                                        width: 1,
                                        color: white,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: h * 0.1,
                                          // width: w * 0.24,
                                          child: Column(
                                            children: [
                                              Spacer(),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                child: text('غياب بدون عذر',
                                                    fontSize: f,
                                                    fontSizesLevel: -1,
                                                    isBold: true,
                                                    textColor: white),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
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
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                    height: h * 0.1,
                                    // width: w * 0.2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            bottomRight: Radius.circular(15))),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Text(
                                            'غياب بعذر',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: white,
                                                fontSize: f * 0.8,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: h * 0.07,
                          width: w * 0.975,
                          decoration:
                              boxDecoration(color: blue.withOpacity(0.8)),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: h * 0.1,
                                  // width: w * 0.6,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: h * 0.1,
                                          // width: w * 0.24,
                                          child: Column(
                                            children: [
                                              Spacer(),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                child: text(state.data.total,
                                                    fontSize: f,
                                                    fontSizesLevel: -1,
                                                    isBold: true,
                                                    textColor: blue),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: h * 0.09,
                                        width: 1,
                                        color: blue,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: h * 0.1,
                                          // width: w * 0.24,
                                          child: Column(
                                            children: [
                                              Spacer(),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                child: text(state.data.noexe,
                                                    fontSize: f,
                                                    fontSizesLevel: -1,
                                                    isBold: true,
                                                    textColor:
                                                        blue.withOpacity(0.8)),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: h * 0.09,
                                        width: 1,
                                        color: blue.withOpacity(0.8),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                    height: h * 0.1,
                                    // width: w * 0.2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            bottomRight: Radius.circular(15))),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Text(
                                            state.data.exe,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: blue.withOpacity(0.8),
                                                fontSize: f * 0.8,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: h * 0.07,
                          width: w - 10,
                          decoration:
                              boxDecoration(color: blue.withOpacity(0.8)),
                          child: Center(
                              child: text('النتيجة : ${state.data.result}',
                                  fontSize: f,
                                  fontSizesLevel: 0,
                                  isBold: true,
                                  textColor: blue.withOpacity(0.9))),
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      height: h * 0.15,
                      width: w,
                      child: Center(
                          child: text('لا يوجد اتصال بالانترنت',
                              fontSize: f,
                              fontSizesLevel: 0,
                              isBold: true,
                              textColor: blue)),
                    );
                  }
                } else {
                  print('it is empty');
                  return Container();
                }
              }),
              Container(
                height: h * 0.1,
                width: w,
                child: Center(
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: text('تفاصيل أيام الغياب',
                          fontSize: f,
                          fontSizesLevel: 1,
                          textColor: color3,
                          isBold: true)),
                ),
              ),
              BlocBuilder<AttendanceSummeryBloc, AttendanceSummeryState>(
                  builder: (context, state) {
                if (state is LoadingState) {
                  return Container(
                    height: h * 0.15,
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
                } else if (state is MyOneAttendanceSummery) {
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
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: h * 0.1,
                                  // width: w * 0.6,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: h * 0.1,
                                          // width: w * 0.24,
                                          child: Column(
                                            children: [
                                              Spacer(),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                child: text('ساعات الغياب',
                                                    fontSize: f,
                                                    fontSizesLevel: -1,
                                                    isBold: true,
                                                    textColor: white),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: h * 0.09,
                                        width: 1,
                                        color: white,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: h * 0.1,
                                          // width: w * 0.24,
                                          child: Column(
                                            children: [
                                              Spacer(),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                child: text('رقم المحاضرة',
                                                    fontSize: f,
                                                    fontSizesLevel: -1,
                                                    isBold: true,
                                                    textColor: white),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
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
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                    height: h * 0.1,
                                    // width: w * 0.2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            bottomRight: Radius.circular(15))),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Text(
                                            'تاريخ المحاضرة',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: white,
                                                fontSize: f * 0.8,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          itemCount: state.data2.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: h * 0.07,
                              width: w * 0.975,
                              margin: EdgeInsets.only(left: 5, right: 5),
                              decoration:
                                  boxDecoration(color: blue.withOpacity(0.8)),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: h * 0.1,
                                      // width: w * 0.6,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: h * 0.1,
                                              // width: w * 0.24,
                                              child: Column(
                                                children: [
                                                  Spacer(),
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    child: text(
                                                        state
                                                            .data2[index].hours,
                                                        fontSize: f,
                                                        fontSizesLevel: -1,
                                                        isBold: true,
                                                        textColor: blue),
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: h * 0.09,
                                            width: 1,
                                            color: blue.withOpacity(0.8),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: h * 0.1,
                                              // width: w * 0.24,
                                              child: Column(
                                                children: [
                                                  Spacer(),
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    child: text(
                                                        state.data2[index]
                                                            .lecture,
                                                        fontSize: f,
                                                        fontSizesLevel: -1,
                                                        isBold: true,
                                                        textColor: blue),
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
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
                                  ),
                                  Expanded(
                                    flex: 1,
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
                                                state.data2[index].date,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: blue,
                                                    fontSize: f,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      height: h * 0.15,
                      width: w,
                      child: Center(
                          child: text('لا يوجد اتصال بالانترنت',
                              fontSize: f,
                              fontSizesLevel: 0,
                              isBold: true,
                              textColor: blue)),
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
    ));
  }
}
