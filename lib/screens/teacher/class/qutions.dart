import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/teacher/createQutionBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/createQutionBloc/event.dart';
import 'package:alwastia/bloc/teacher/createQutionBloc/state.dart';
import 'package:alwastia/bloc/teacher/getMyLecturesBloc/model.dart';
import 'package:alwastia/bloc/teacher/getMyQuestionsBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyQuestionsBloc/event.dart';
import 'package:alwastia/bloc/teacher/getMyQuestionsBloc/state.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';

class Qutions extends StatefulWidget {
  late LectureModel element;
  Qutions({required this.element});
  @override
  State<Qutions> createState() => _QutionsState(element: element);
}

class _QutionsState extends State<Qutions> with AutomaticKeepAliveClientMixin {
  late LectureModel element;
  _QutionsState({required this.element});
  var qutionController = TextEditingController();
  var asnwerController = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetQuestionBloc>(context)
        .add(GetMyQuestions(lectreId: element.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: listview(),
    );
  }

  @override
  bool get wantKeepAlive => true;
  Widget listview() {
    return BlocBuilder<GetQuestionBloc, GetQuestionsState>(
        builder: (context, state) {
      if (state is LoadingState2) {
        return Container(
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
        );
      } else if (state is MyQuestions) {
        if (state.connection) {
          return Container(
            margin: EdgeInsets.only(left: 16, top: 20, right: 16),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  // height: h * 0.1,
                  width: w,
                  margin: EdgeInsets.only(top: 10),
                  decoration: boxDecoration(
                    radius: 10,
                    bgColor: white,
                    showShadow: true,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: w,
                        padding: EdgeInsets.only(
                            right: w * 0.05, left: w * 0.1, top: h * 0.01),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                state.data[index].question + " " + qutionmark,
                                style: TextStyle(
                                    color: color3,
                                    fontSize: f,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                      Container(
                        height: h * 0.01,
                      ),
                      Container(
                        // height: h * 0.04,
                        margin:
                            EdgeInsets.only(right: w * 0.03, left: w * 0.05),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                state.data[index].answer,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: color3,
                                  fontSize: f,
                                ),
                              )),
                        ),
                      ),
                      Container(
                        height: h * 0.04,
                        child: Row(
                          children: <Widget>[
                            Container(
                              // width: w * 0.1,
                              margin: EdgeInsets.only(left: w * 0.02),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: text(state.data[index].date,
                                    fontSize: f * 0.08,
                                    fontSizesLevel: -1,
                                    textColor: color3),
                              ),
                            ),
                            Spacer(),
                          ],
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
            width: w,
            height: h * 0.8,
            child: Column(
              children: [
                Container(
                  height: h * 0.5,
                  width: w * 0.8,
                  decoration: boxDecoration(
                      imageExsit: true,
                      bgColor: Colors.transparent,
                      imageAsset: 'assets/images/noNet2.png',
                      boxfit: BoxFit.contain),
                ),
                Container(
                  height: h * 0.02,
                ),
                Material(
                  child: InkWell(
                      splashColor: white.withOpacity(0.5),
                      onTap: () {
                        BlocProvider.of<GetQuestionBloc>(context)
                            .add(GetMyQuestions(lectreId: element.id));
                      },
                      child: buttons('أعد المحاولة', 1, blue)),
                )
              ],
            ),
          );
        }
      } else {
        return Container();
      }
    });
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
      icon: Icon(Icons.question_answer),
      label: Text("إضافة سؤال"),
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
        child: BlocBuilder<CreateQuestionBloc, CreateQuestionState>(
            builder: (context, state) {
          return state is LoadingState
              ? Center(
                  child: Container(
                    height: h * 0.03,
                    width: h * 0.03,
                    child: CircularProgressIndicator(
                      color: white,
                      strokeWidth: 3,
                    ),
                  ),
                )
              : Center(
                  child: Text(txt,
                      style: TextStyle(
                          fontSize: f,
                          fontWeight: FontWeight.bold,
                          color: white)),
                );
        }),
      ),
    );
  }

  Widget buildSheets(double height, double width, double fontx) {
    bool showError = false;
    String errorString = '';
    return FractionallySizedBox(
      heightFactor: 0.86,
      child: StatefulBuilder(builder: (context, StateSetter setSheetState) {
        return BlocListener<CreateQuestionBloc, CreateQuestionState>(
          listener: (context, state) => {
            if (state is CreateQuestionDone)
              {
                if (state.connection)
                  {
                    if (state.res)
                      {
                        BlocProvider.of<GetQuestionBloc>(context)
                            .add(GetMyQuestions(lectreId: element.id)),
                        setSheetState(() {
                          qutionController.clear();
                          asnwerController.clear();
                          showError = true;
                          errorString = 'تم  اضافة السؤال  بنجاح';
                        })
                      }
                    else
                      {
                        setSheetState(() {
                          showError = true;
                          errorString = 'حصل خطاء ما';
                        })
                      }
                  }
                else
                  {
                    setSheetState(() {
                      showError = true;
                      errorString = 'لا يوجد إتصال بالانترنت';
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
              height: height * 0.86,
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
                      buildTextField2small(
                          h, w, f, qutionController, 'السؤال', false),
                      Container(
                        height: h * 0.02,
                      ),
                      buildTextField2(
                          h, w, f, asnwerController, 'الإجابة', false),
                      Container(
                        height: h * 0.05,
                      ),
                      InkWell(
                          onTap: () {
                            print('sss');
                            if (qutionController.text.isEmpty) {
                              setSheetState(() {
                                showError = true;
                                errorString = "فضلا ادخل  السؤال";
                              });
                            } else if (asnwerController.text.isEmpty) {
                              setSheetState(() {
                                showError = true;
                                errorString = "فضلا ادخل  الإجابة";
                              });
                            } else
                              BlocProvider.of<CreateQuestionBloc>(context).add(
                                  CreateQuestion(
                                      qution: qutionController.text,
                                      answer: asnwerController.text,
                                      lectureId: element.id));
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

  Directionality buildTextField2small(double height, double width, double fontx,
      TextEditingController controller, String hint, bool secureWords) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: height * 0.25,
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.only(
            left: width * 0.03, right: width * 0.03, top: height * 0.01),
        decoration: boxDecoration(radius: 5, color: blue.withOpacity(0.2)),
        child: TextField(
          controller: controller,
          maxLines: null,
          minLines: 3,
          textAlign: TextAlign.right,
          style: TextStyle(
              color: color3,
              fontFamily: 'DroidArabicKufi',
              fontSize: fontx - fontx * 0.1,
              fontWeight: FontWeight.bold),
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
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

  Directionality buildTextField2(double height, double width, double fontx,
      TextEditingController controller, String hint, bool secureWords) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: height * 0.25,
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.only(
            left: width * 0.03, right: width * 0.03, top: height * 0.01),
        decoration: boxDecoration(radius: 5, color: blue.withOpacity(0.2)),
        child: TextField(
          controller: controller,
          maxLines: null,
          minLines: 6,
          textAlign: TextAlign.right,
          style: TextStyle(
              color: color3,
              fontFamily: 'DroidArabicKufi',
              fontSize: fontx - fontx * 0.1,
              fontWeight: FontWeight.bold),
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
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
