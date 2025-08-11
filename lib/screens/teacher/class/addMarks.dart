import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/teacher/getMyClassesBloc/model.dart';
import 'package:alwastia/bloc/teacher/getMyStudents.dart/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyStudents.dart/event.dart';
import 'package:alwastia/bloc/teacher/getMyStudents.dart/state.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';

class ClassStudentsMarks extends StatefulWidget {
  late ClassModel element;
  ClassStudentsMarks({required this.element});

  @override
  State<ClassStudentsMarks> createState() =>
      _ClassStudentsMarksState(element: element);
}

class _ClassStudentsMarksState extends State<ClassStudentsMarks> {
  late ClassModel element;

  List<TextEditingController> controllers = [];
  _ClassStudentsMarksState({required this.element});
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetClassStudentsBloc>(context)
        .add(GetMyStudents(classId: element.id));
  }

  var markController = TextEditingController();

  int itemindexforClosing = 0;
  List<bool> stdState = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<GetClassStudentsBloc, GetClassStudentsState>(
            builder: (context, state) {
          String stdCount = '';
          state is MyStudents ? stdCount = state.data.length.toString() : '';
          if (state is MyStudents) {
            for (var item in state.data) {
              stdState.add(true);
            }
          }
          return SingleChildScrollView(
            child: Column(
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
                        height: h * 0.8,
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
                        ? Container(
                            height: h * 0.8,
                            width: w,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (index == state.data.length - 1) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: h * 0.12,
                                        width: w,
                                        margin: EdgeInsets.only(left: w * 0.05),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: h * 0.12,
                                              width: w * 0.2,
                                              child: Column(
                                                children: <Widget>[
                                                  Spacer(),
                                                  text('درجة الطالب',
                                                      fontSize: f,
                                                      fontSizesLevel: 0,
                                                      textColor: color3),
                                                  Spacer(),
                                                  Container(
                                                    height: h * 0.06,
                                                    width: w * 0.2,
                                                    child: buildTextField(
                                                        h,
                                                        w * 0.2,
                                                        f,
                                                        markController,
                                                        'الدرجة',
                                                        false),
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              height: h * 0.12,
                                              width: w * 0.5,
                                              alignment: Alignment.centerRight,
                                              child: Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: Column(
                                                  children: [
                                                    Spacer(),
                                                    Container(
                                                      width: w * 0.5,
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
                                                      width: w * 0.5,
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: text(
                                                          "تم الإنظمام بتاريخ ${state.data[index].date}",
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
                                                          null
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
                                                              imageUrl:
                                                                  personImagesPath +
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
                                      ),
                                      Container(
                                        height: h * 0.03,
                                      ),
                                      buttons('حفظ', 0, blue, 1)
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      Container(
                                        height: h * 0.12,
                                        width: w,
                                        margin: EdgeInsets.only(left: w * 0.05),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: h * 0.12,
                                              width: w * 0.2,
                                              child: Column(
                                                children: <Widget>[
                                                  Spacer(),
                                                  text('درجة الطالب',
                                                      fontSize: f,
                                                      fontSizesLevel: 0,
                                                      textColor: color3),
                                                  Spacer(),
                                                  Container(
                                                    height: h * 0.06,
                                                    width: w * 0.2,
                                                    child: buildTextField(
                                                        h,
                                                        w * 0.2,
                                                        f,
                                                        markController,
                                                        'الدرجة',
                                                        false),
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              height: h * 0.12,
                                              width: w * 0.5,
                                              alignment: Alignment.centerRight,
                                              child: Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: Column(
                                                  children: [
                                                    Spacer(),
                                                    Container(
                                                      width: w * 0.5,
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
                                                      width: w * 0.5,
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: text(
                                                          "تم الإنظمام بتاريخ ${state.data[index].date}",
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
                                                          null
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
                                                              imageUrl:
                                                                  personImagesPath +
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
                                }
                              },
                            ),
                          )
                        : Container()
              ],
            ),
          );
        }),
      ),
    );
  }

  Directionality buildTextField(double height, double width, double fontx,
      TextEditingController controller, String hint, bool secureWords) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: height * 0.05,
        width: width,
        padding: EdgeInsets.only(top: 16),
        margin: EdgeInsets.only(
            left: width * 0.03, right: width * 0.03, top: height * 0.01),
        decoration: boxDecoration(
            bgColor: Colors.transparent,
            radius: 5,
            color: blue.withOpacity(0.2)),
        child: TextField(
          controller: controller,
          maxLines: 1,
          minLines: 1,
          textAlign: TextAlign.right,
          style: TextStyle(
              color: color3,
              fontFamily: 'DroidArabicKufi',
              fontSize: fontx - fontx * 0.1,
              fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          cursorColor: blue,
          decoration: InputDecoration(
            // fillColor: white,
            // filled: true,
            hintText: hint,
            hintStyle: TextStyle(
                color: Colors.grey,
                fontFamily: 'DroidArabicKufi',
                fontSize: fontx,
                fontWeight: FontWeight.bold),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15)),
          ),
          obscureText: secureWords,
        ),
      ),
    );
  }

  Material buttons(String txt, int click, Color color, int n) {
    return Material(
      child: Container(
          height: h * 0.07,
          width: w * 0.7,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3))
            ],
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color,
                  color,
                ]),
          ),
          child:
              // BlocBuilder<CloseClassBloc, CloseClassState>(
              //     builder: (context, state) {
              //   return state is LoadingState2 && n == 1
              //       ? Center(
              //           child: Container(
              //             height: h * 0.03,
              //             width: h * 0.03,
              //             child: CircularProgressIndicator(
              //               color: white,
              //               strokeWidth: 3,
              //             ),
              //           ),
              //         )
              //       :
              Center(
            child: Text(txt,
                style: TextStyle(
                    fontSize: f, fontWeight: FontWeight.bold, color: white)),
          )
          // ;
          // }
          // ),
          ),
    );
  }
}
