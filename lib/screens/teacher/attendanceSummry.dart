import 'package:alwastia/bloc/teacher/getAttendanceSumery.dart/bloc.dart';
import 'package:alwastia/bloc/teacher/getAttendanceSumery.dart/event.dart';
import 'package:alwastia/bloc/teacher/getAttendanceSumery.dart/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:alwastia/bloc/teacher/getMyClassesBloc/model.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';

class AtdSummry extends StatefulWidget {
  late ClassModel element;
  AtdSummry({required this.element});

  @override
  State<AtdSummry> createState() => _AtdSummryState(element: element);
}

class _AtdSummryState extends State<AtdSummry> {
  late ClassModel element;
  _AtdSummryState({required this.element});
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AttendanceSummeryBloc>(context)
        .add(GetAttendanceSummery(classId: element.id));
  }

  List<String> head = [
    'اسم الطالب',
    'غائب بعذر',
    'غائب بدون عذر',
    'اجمالي الغياب',
    'النتيجة',
  ];

  int itemindexforClosing = 0;
  List<bool> stdState = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h * 0.7,
      width: w,
      child: BlocListener<AttendanceSummeryBloc, AttendanceSummeryState>(
        listener: (context, state) => {
          // if (state is MyAttendanceSummery)
          //   {
          //     for (var item in state.data)
          //       {print(item.status.toString()), stdState.add(item.status == 0)},
          //     setState(() {})
          //   }
        },
        child: BlocBuilder<AttendanceSummeryBloc, AttendanceSummeryState>(
            builder: (context, state) {
          return Column(
            children: [
              Container(
                height: h * 0.1,
                width: w,
                child: Center(
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: text(('ملخص التحضير'),
                          fontSize: f,
                          fontSizesLevel: 1,
                          textColor: blue,
                          isBold: true)),
                ),
              ),
              state is LoadingState
                  ? Container(
                      width: w,
                      height: h * 0.6,
                      child: Center(
                        child: Container(
                          height: h * 0.04,
                          width: h * 0.04,
                          child: CircularProgressIndicator(
                            color: blue,
                            strokeWidth: 3,
                          ),
                        ),
                      ),
                    )
                  : state is MyAttendanceSummery
                      ? state.data.isEmpty
                          ? Container(
                              height: h * 0.6,
                              width: w,
                              child: Center(
                                child: text('لا يوجد ملخص تحضير بعد',
                                    fontSize: f,
                                    fontSizesLevel: 1,
                                    isBold: true,
                                    textColor: Colors.black),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: SingleChildScrollView(
                                reverse: true,
                                scrollDirection: Axis.horizontal,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: List.generate(
                                          head.length,
                                          (index) => Container(
                                            width: index == 0
                                                ? 250
                                                : index == head.length - 1
                                                    ? 150
                                                    : 150.0,
                                            height: 50.0,
                                            decoration: boxDecoration(
                                                color: white.withOpacity(0.3),
                                                bgColor: blue),
                                            child: Center(
                                              child: Text(
                                                head[index],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // SizedBox(height: 10.0),
                                      Container(
                                        width:
                                            850.0, // Set a fixed width for the content
                                        height: 400,
                                        child: BlocBuilder<
                                                AttendanceSummeryBloc,
                                                AttendanceSummeryState>(
                                            builder: (context, state) {
                                          if (state is LoadingState) {
                                            return Container(
                                              height: 300,
                                              width: w,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: blue,
                                                  strokeWidth: 2,
                                                ),
                                              ),
                                            );
                                          } else if (state
                                              is MyAttendanceSummery) {
                                            return ListView.builder(
                                              // shrinkWrap: true,
                                              // physics:
                                              //     NeverScrollableScrollPhysics(),
                                              itemCount: state.data.length,
                                              itemBuilder: (context, index) {
                                                List<String> rowData = [];
                                                rowData = [
                                                  state.data[index].name,
                                                  state.data[index].exe,
                                                  state.data[index].noexe,
                                                  state.data[index].total,
                                                  state.data[index].result,
                                                ];
                                                return Row(
                                                  children: List.generate(
                                                    rowData.length,
                                                    (index2) => Container(
                                                      width: index2 == 0
                                                          ? 250
                                                          : index2 ==
                                                                  head.length -
                                                                      1
                                                              ? 150
                                                              : 150.0,
                                                      height: 45.0,
                                                      decoration: boxDecoration(
                                                          bgColor: Colors
                                                              .transparent,
                                                          color:
                                                              blue.withOpacity(
                                                                  0.2)),
                                                      child: Center(
                                                        child: InkWell(
                                                          onTap: () {
                                                            // showDialog(
                                                            //   context: context,
                                                            //   builder: (BuildContext
                                                            //       context) {
                                                            //     return textDialog(
                                                            //         rowData[
                                                            //             index2]);
                                                            //   },
                                                            // );
                                                          },
                                                          child: Text(
                                                            rowData[index2],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          } else {
                                            return Container();
                                          }
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                      : Container()
            ],
          );
        }),
      ),
    );
  }
}
