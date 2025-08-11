import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';
import 'package:alwastia/bloc/teacher/StudentAttendanceBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/StudentAttendanceBloc/event.dart';
import 'package:alwastia/bloc/teacher/StudentAttendanceBloc/state.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';

class AttendanceSumery extends StatefulWidget {
  late ClassModel2 element;
  AttendanceSumery({required this.element});

  @override
  State<AttendanceSumery> createState() =>
      _AttendanceSumeryState(element: element);
}

class _AttendanceSumeryState extends State<AttendanceSumery> {
  late ClassModel2 element;
  _AttendanceSumeryState({required this.element});
  var titleController = TextEditingController();
  var markController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<OneStudentAttendanceBloc>(context)
        .add(GetOneStudentAttendance(classId: element.id));
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
                    child: text('الحضور والغياب',
                        fontSize: f,
                        fontSizesLevel: 1,
                        textColor: color3,
                        isBold: true)),
              ),
            ),
            Container(
              height: h * 0.06,
              width: w * 0.9,
              decoration: boxDecoration(
                  showShadow: true, bgColor: blue.withOpacity(0.9)),
              child: Row(
                children: [
                  Container(
                    width: w * 0.06,
                  ),
                  Container(
                    // width: w * 0.3,
                    child: Center(
                      child: text('الحضور والغياب',
                          fontSize: f,
                          fontSizesLevel: 1,
                          isBold: true,
                          textColor: white),
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: w * 0.5 - 3,
                    child: text('المحاضرة',
                        fontSize: f,
                        fontSizesLevel: 1,
                        isBold: true,
                        textColor: white),
                  ),
                ],
              ),
            ),
            BlocBuilder<OneStudentAttendanceBloc, OneStudentAttendanceState>(
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
              } else if (state is MyOneStudentAttendance) {
                if (state.connection) {
                  return Container(
                    width: w * 0.9,
                    decoration: boxDecoration(showShadow: true),
                    child: ListView.builder(
                      itemCount: state.data.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: h * 0.08,
                          width: w * 0.9,
                          decoration: boxDecoration(color: green),
                          child: Row(
                            children: [
                              Container(
                                width: w * 0.06,
                              ),
                              Container(
                                width: w * 0.3,
                                child: Center(
                                  child: state.data[index].attendance == 1
                                      ? text(
                                         "حاضر",
                                          fontSize: f,
                                          fontSizesLevel: 1,
                                          isBold: true,
                                          textColor: green)
                                      : text(
                                          'غائب',
                                          fontSize: f,
                                          fontSizesLevel: 1,
                                          isBold: true,
                                          textColor: Colors.red.shade300),
                                ),
                              ),
                              Container(
                                width: w * 0.5 - 5,
                                child: text(state.data[index].name,
                                    fontSize: f,
                                    fontSizesLevel: 1,
                                    isBold: true,
                                    textColor: color3),
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
                          BlocProvider.of<OneStudentAttendanceBloc>(context)
                              .add(
                                  GetOneStudentAttendance(classId: element.id));
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
