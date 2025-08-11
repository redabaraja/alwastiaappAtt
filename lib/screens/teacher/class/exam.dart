import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/teacher/createExamBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/createExamBloc/event.dart';
import 'package:alwastia/bloc/teacher/createExamBloc/state.dart';
import 'package:alwastia/bloc/teacher/getMyClassesBloc/model.dart';
import 'package:alwastia/bloc/teacher/getMyExamsBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyExamsBloc/event.dart';
import 'package:alwastia/bloc/teacher/getMyExamsBloc/state.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/screens/teacher/class/addMarks.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';

class Exam extends StatefulWidget {
  late ClassModel element;
  Exam({required this.element});

  @override
  State<Exam> createState() => _ExamState(element: element);
}

class _ExamState extends State<Exam> {
  late ClassModel element;
  _ExamState({required this.element});
  var titleController = TextEditingController();
  var markController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetExamsBloc>(context).add(GetMyExam(classId: element.id));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          Container(
            height: h * 0.1,
            width: w,
            child: Center(
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: text('الإمتحانات',
                      fontSize: f,
                      fontSizesLevel: 1,
                      textColor: color3,
                      isBold: true)),
            ),
          ),
          BlocBuilder<GetExamsBloc, GetExamState>(builder: (context, state) {
            if (state is LoadingState2) {
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
            } else if (state is MyExams) {
              if (state.connection) {
                return Container(
                  height: h * 0.8,
                  width: w * 0.9,
                  child: ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ClassStudentsMarks(element: element)));
                        },
                        child: Container(
                          height: h * 0.1,
                          width: w * 0.9,
                          margin: EdgeInsets.only(top: h * 0.02),
                          decoration: boxDecoration(
                              showShadow: true, bgColor: white, radius: 5),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: w * 0.04,
                              ),
                              Container(
                                height: h * 0.1,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: text(state.data[index].date,
                                      fontSize: f,
                                      fontSizesLevel: 0,
                                      textColor: color3),
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: h * 0.1,
                                child: Center(
                                  child: text(state.data[index].name,
                                      fontSize: f,
                                      fontSizesLevel: 0,
                                      textColor: color3,
                                      isBold: true),
                                ),
                              ),
                              Container(
                                width: w * 0.03,
                              ),
                              Container(
                                height: h * 0.08,
                                width: h * 0.08,
                                decoration: boxDecoration(
                                    radius: 100,
                                    imageExsit: true,
                                    imageAsset: 'assets/images/exam.png'),
                              ),
                              Container(
                                width: w * 0.02,
                              ),
                            ],
                          ),
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
                        BlocProvider.of<GetExamsBloc>(context)
                            .add(GetMyExam(classId: element.id));
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
    ));
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        showModalBottomSheet(
            backgroundColor: white,
            isScrollControlled: true,
            barrierColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            context: context,
            builder: (context) => buildSheets(
                  h,
                  w,
                  f,
                ));
      },
      backgroundColor: green,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      foregroundColor: white,
      icon: Icon(Icons.notification_add),
      label: Text("إضافة إمتحان"),
    );
  }

  Material buttons(String txt, int click, Color color) {
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
          child: BlocBuilder<CreateExamBloc, CreateExamState>(
              builder: (context, state) {
            return state is LoadingState
                ? Center(
                    child: Container(
                    width: h * 0.03,
                    height: h * 0.03,
                    child: CircularProgressIndicator(
                      color: white,
                      strokeWidth: 2,
                    ),
                  ))
                : Center(
                    child: Text(txt,
                        style: TextStyle(
                            fontSize: f,
                            fontWeight: FontWeight.bold,
                            color: white)),
                  );
          })),
    );
  }

  Widget buildSheets(double height, double width, double fontx) {
    bool showError = false;
    String errorString = '';
    return FractionallySizedBox(
      heightFactor: 0.7,
      child: StatefulBuilder(builder: (context, StateSetter setSheetState) {
        return BlocListener<CreateExamBloc, CreateExamState>(
          listener: (context, state) => {
            if (state is CreateExamDone)
              {
                if (state.res)
                  {
                    setSheetState(() {
                      showError = true;
                      errorString = 'تم إضافة الامتحان بنجاح';
                    }),
                    BlocProvider.of<GetExamsBloc>(context)
                        .add(GetMyExam(classId: element.id))
                  }
                else
                  {
                    setSheetState(() {
                      showError = true;
                      errorString = 'حصل خطأ ما';
                    })
                  }
              }
          },
          child: Scaffold(
            body: Container(
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              height: height * 0.7,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 3),
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  // height: height * 0.41,
                  child: Column(
                    children: [
                      Container(
                        height: h * 0.05,
                      ),
                      buildTextField(
                          h, w, f, titleController, 'عنوان الإمتحان', false),
                      Container(
                        height: h * 0.02,
                      ),
                      buildTextField(
                          h, w, f, markController, 'درجة الإمتحان', false),
                      Container(
                        height: h * 0.02,
                      ),
                      InkWell(
                          onTap: () {
                            if (titleController.text.isEmpty) {
                              setSheetState(() {
                                showError = true;
                                errorString = 'فضلا ادخل عنوان الإمتحان';
                              });
                            } else if (markController.text.isEmpty) {
                              setSheetState(() {
                                showError = true;
                                errorString = 'فضلا ادخل درجة الإمتحان';
                              });
                            } else {
                              BlocProvider.of<CreateExamBloc>(context).add(
                                  CreateExam(
                                      name: titleController.text,
                                      classId: element.id,
                                      max: markController.text));
                            }
                          },
                          child: buttons('إضافة', 0, green)),
                      Container(height: h * 0.05),
                      showError
                          ? Container(
                              child: Center(
                                child: Text(errorString,
                                    style: TextStyle(
                                        color: Colors.red.shade200,
                                        fontSize: f,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Directionality buildTextField(double height, double width, double fontx,
      TextEditingController controller, String hint, bool secureWords) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: height * 0.07,
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.only(
            left: width * 0.03, right: width * 0.03, top: height * 0.01),
        decoration: boxDecoration(radius: 5, color: blue.withOpacity(0.2)),
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
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          cursorColor: blue,
          decoration: InputDecoration(
            fillColor: white,
            filled: true,
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
}
