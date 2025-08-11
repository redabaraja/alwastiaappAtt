import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/teacher/CloseStudentInClass/bloc.dart';
import 'package:alwastia/bloc/teacher/CloseStudentInClass/event.dart';
import 'package:alwastia/bloc/teacher/getMyClassesBloc/model.dart';
import 'package:alwastia/bloc/teacher/getMyStudents.dart/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyStudents.dart/event.dart';
import 'package:alwastia/bloc/teacher/getMyStudents.dart/state.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';

class ClassStudents extends StatefulWidget {
  late ClassModel element;
  ClassStudents({required this.element});

  @override
  State<ClassStudents> createState() => _ClassStudentsState(element: element);
}

class _ClassStudentsState extends State<ClassStudents> {
  late ClassModel element;
  _ClassStudentsState({required this.element});
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetClassStudentsBloc>(context)
        .add(GetMyStudents(classId: element.id));
  }

  int itemindexforClosing = 0;
  List<bool> stdState = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h * 0.7,
      width: w,
      child: BlocListener<GetClassStudentsBloc, GetClassStudentsState>(
        listener: (context, state) => {
          if (state is MyStudents)
            {
              for (var item in state.data)
                {print(item.status.toString()), stdState.add(item.status == 0)},
              setState(() {})
            }
        },
        child: BlocBuilder<GetClassStudentsBloc, GetClassStudentsState>(
            builder: (context, state) {
          String stdCount = '';
          state is MyStudents ? stdCount = state.data.length.toString() : '';

          return Column(
            children: [
              Container(
                height: h * 0.1,
                width: w,
                child: Center(
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: text(('عدد الطلاب:' + " " + stdCount),
                          fontSize: f,
                          fontSizesLevel: 1,
                          textColor: color3,
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
                  : state is MyStudents
                      ? state.data.isEmpty
                          ? Container(
                              height: h * 0.6,
                              width: w,
                              child: Center(
                                child: text('لا يوجد طلاب في هذا المقرر بعد',
                                    fontSize: f,
                                    fontSizesLevel: 1,
                                    isBold: true,
                                    textColor: Colors.black),
                              ),
                            )
                          : Expanded(
                            child: ListView.builder(
                                itemCount: state.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: h * 0.12,
                                        width: w,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: w * 0.06,
                                            ),
                                            // Container(
                                            //   height: h * 0.03,
                                            //   width: w * 0.1,
                                            //   child: Center(
                                            //     child: Switch(
                                            //       onChanged: (v) {
                                            //         if (v) {
                                            //           // itemindexforClosing = index;
                                            //           // closing = true;
                                            //           BlocProvider.of<
                                            //                       CloseStdBloc>(
                                            //                   context)
                                            //               .add(ActivateStd(
                                            //                   stdId: state
                                            //                       .data[index]
                                            //                       .id));
                                            //           setState(() {
                                            //             stdState[index] = true;
                                            //           });
                                            //         } else {
                                            //           // itemindexforClosing = index;
                                            //           BlocProvider.of<
                                            //                       CloseStdBloc>(
                                            //                   context)
                                            //               .add(CloseStd(
                                            //                   stdId: state
                                            //                       .data[index]
                                            //                       .id));
                                            //           setState(() {
                                            //             stdState[index] = false;
                                            //           });
                                            //         }
                                            //       },
                                            //       value: stdState[index],
                                            //       activeColor: blue,
                                            //     ),
                                            //   ),
                                            // ),
                          
                                            Spacer(),
                                            Container(
                                              height: h * 0.12,
                                              width: w * 0.6,
                                              alignment: Alignment.centerRight,
                                              child: Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: Column(
                                                  children: [
                                                    Spacer(),
                                                    Container(
                                                      width: w * 0.6,
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: text(
                                                          state
                                                              .data[index].name,
                                                          fontSize: f,
                                                          fontSizesLevel: 1,
                                                          isBold: true,
                                                          textaligntype: 2,
                                                          textColor: color3),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      width: w * 0.6,
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: text(
                                                          "رقم القيد :    ${state.data[index].userID}",
                                                          fontSize: f,
                                                          fontSizesLevel: 0,
                                                          textColor: color3),
                                                    ),
                                                    Spacer()
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: w * 0.04,
                                            ),
                                            Container(
                                              height: h * 0.12,
                                              width: w * 0.2,
                                              child: Center(
                                                  child: state.data[index]
                                                              .logo ==
                                                          ''
                                                      ? Container(
                                                          height: h * 0.08,
                                                          width: h * 0.08,
                                                          decoration: boxDecoration(
                                                              radius: 100,
                                                              color: blue,
                                                              imageExsit: true,
                                                              boxfit:
                                                                  BoxFit.cover,
                                                              imageAsset:
                                                                  'assets/images/person.png'),
                                                        )
                                                      : Container(
                                                          height: h * 0.08,
                                                          width: h * 0.08,
                                                          decoration: boxDecoration(
                                                              radius: 100,
                                                              color: blue,
                                                              boxfit:
                                                                  BoxFit.cover,
                                                              imageExsit: true,
                                                              imagetype: 1,
                                                              imageUrl: baseUrl3 +
                                                                  state
                                                                      .data[
                                                                          index]
                                                                      .logo),
                                                        )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 1,
                                        color: color3.withOpacity(0.1),
                                      )
                                    ],
                                  );
                                },
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
