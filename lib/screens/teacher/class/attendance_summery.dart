import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/teacher/getAttendanceSumery.dart/bloc.dart';
import 'package:alwastia/bloc/teacher/getAttendanceSumery.dart/event.dart';
import 'package:alwastia/bloc/teacher/getAttendanceSumery.dart/state.dart';
import 'package:alwastia/bloc/teacher/getMyClassesBloc/model.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';

class AttendanceSumery extends StatefulWidget {
  late ClassModel element;
  AttendanceSumery({required this.element});

  @override
  State<AttendanceSumery> createState() =>
      _AttendanceSumeryState(element: element);
}

class _AttendanceSumeryState extends State<AttendanceSumery> {
  late ClassModel element;
  _AttendanceSumeryState({required this.element});
  var titleController = TextEditingController();
  var markController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AttendanceSummeryBloc>(context)
        .add(GetAttendanceSummery(classId: element.id));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
            Container(
              height: h * 0.01,
            ),
            Container(
              height: h * 0.08,
              width: w * 0.95,
              decoration: boxDecoration(
                  showShadow: true, bgColor: blue.withOpacity(0.9)),
              child: Row(
                children: [
                  Container(
                    width: w * 0.16,
                    child: Center(
                      child: text('النتيجة',
                          fontSize: f,
                          fontSizesLevel: -1,
                          isBold: true,
                          textColor: white),
                    ),
                  ),
                  Container(
                    width: w * 0.08,
                    child: Center(
                      child: Text(
                        'مجموع الغياب',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: f * 0.6,
                            fontWeight: FontWeight.bold,
                            color: white),
                      ),
                      //  text('',
                      //     fontSize: f,
                      //     fontSizesLevel: -1,
                      //     isBold: true,
                      //     textColor: white),
                    ),
                  ),
                  Container(
                    width: w * 0.08,
                    child: Center(
                      child: Text(
                        'غائب بدون عذر',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: f * 0.6,
                            fontWeight: FontWeight.bold,
                            color: white),
                      ),
                    ),
                  ),
                  Container(
                    width: w * 0.08,
                    child: Center(
                      child: Text(
                        'غائب بعذر',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: f * 0.6,
                            fontWeight: FontWeight.bold,
                            color: white),
                      ),
                    ),
                  ),
                  Container(
                    width: w * 0.5 - 3,
                    child: text('اسم الطالب',
                        fontSize: f,
                        fontSizesLevel: 1,
                        isBold: true,
                        textColor: white),
                  ),
                ],
              ),
            ),
            BlocBuilder<AttendanceSummeryBloc, AttendanceSummeryState>(
                builder: (context, state) {
              if (state is LoadingState) {
                return Container(
                  height: h * 0.8,
                  width: w * 0.9,
                  child: Center(
                    child: Container(
                      width: h * 0.04,
                      height: h * 0.04,
                      child: CircularProgressIndicator(
                        color: blue,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                );
              } else if (state is MyAttendanceSummery) {
                if (state.connection) {
                  if (state.data.isEmpty) {
                    return Container(
                      height: h * 0.3,
                      width: w,
                      child: Center(
                          child: text('لا يوجد ملخص تحضير بعد',
                              fontSize: f,
                              fontSizesLevel: 1,
                              isBold: true,
                              textColor: blue)),
                    );
                  } else
                    return Container(
                      width: w * 0.95,
                      decoration: boxDecoration(showShadow: true),
                      child: ListView.builder(
                        itemCount: state.data.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: h * 0.08,
                            width: w * 0.95,
                            decoration: boxDecoration(color: green),
                            child: Row(
                              children: [
                                Container(
                                  width: w * 0.16,
                                  child: Center(
                                    child: text(state.data[index].result,
                                        fontSize: f,
                                        fontSizesLevel: 1,
                                        isBold: true,
                                        textColor: color3),
                                  ),
                                ),
                                Container(
                                  width: w * 0.08,
                                  child: Center(
                                    child: text(
                                        state.data[index].total.toString(),
                                        fontSize: f,
                                        fontSizesLevel: 1,
                                        isBold: true,
                                        textColor: blue),
                                  ),
                                ),
                                Container(
                                  width: w * 0.08,
                                  child: Center(
                                    child: text(
                                        state.data[index].noexe.toString(),
                                        fontSize: f,
                                        fontSizesLevel: 1,
                                        isBold: true,
                                        textColor: Colors.red.shade200),
                                  ),
                                ),
                                Container(
                                  width: w * 0.08,
                                  child: Center(
                                    child: text(
                                        state.data[index].exe.toString(),
                                        fontSize: f,
                                        fontSizesLevel: 1,
                                        isBold: true,
                                        textColor: green),
                                  ),
                                ),
                                Container(
                                  width: w * 0.5 - 5,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: text(state.data[index].name,
                                        fontSize: f,
                                        fontSizesLevel: 1,
                                        isBold: true,
                                        textColor: color3),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                } else {
                  return Container(
                    height: h * 0.8,
                    width: w * 0.9,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<AttendanceSummeryBloc>(context)
                              .add(GetAttendanceSummery(classId: element.id));
                        },
                        child: Container(
                          height: h * 0.5,
                          width: w * 0.7,
                          decoration: boxDecoration(
                              imageExsit: true,
                              imageAsset: "assets/images/noNet2.png"),
                        ),
                      ),
                    ),
                  );
                }
              } else {
                return Container();
              }
            })
          ],
        ),
      ),
    ));
  }
}
