import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/teacher/getMyLecturesBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyLecturesBloc/event.dart';
import 'package:alwastia/bloc/teacher/getMyLecturesBloc/model.dart';
import 'package:alwastia/bloc/teacher/updateLectureBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/updateLectureBloc/event.dart';
import 'package:alwastia/bloc/teacher/updateLectureBloc/state.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';

class UpdateLectureInfo extends StatefulWidget {
  late LectureModel element;
  late int classid;
  UpdateLectureInfo({required this.element, required this.classid});
  @override
  State<UpdateLectureInfo> createState() =>
      _UpdateLectureInfoState(element: element, classid: classid);
}

class _UpdateLectureInfoState extends State<UpdateLectureInfo> {
  bool showError = false;
  String errorString = '';
  late LectureModel element;
  late int classid;
  _UpdateLectureInfoState({required this.element, required this.classid});
  var lecturenamecontroller = TextEditingController();
  var lecturedisccontroller = TextEditingController();
  // var classcodeccontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    lecturenamecontroller.text = element.name;
    lecturedisccontroller.text = element.descr;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocListener<UpdateLectureBloc, UpdateLectureState>(
      listener: (context, state) => {
        if (state is UpdateLectureDone)
          {
            if (state.connection)
              {
                if (state.res)
                  {
                    BlocProvider.of<GetLecturesBloc>(context)
                        .add(GetMyLectures(classId: classid)),
                    setState(() {
                      showError = true;
                      errorString = 'تم تعديل معلومات المحاضرة بنجاح';
                    })
                  }
                else
                  {
                    setState(() {
                      showError = true;
                      errorString = 'حصل خطاء ما';
                    })
                  }
              }
            else
              {
                setState(() {
                  showError = true;
                  errorString = 'لا يوجد إتصال بالانترنت';
                })
              }
          }
      },
      child: Scaffold(
        body: Container(
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
                  Container(
                    child: text('عنوان المحاضرة',
                        fontSize: f,
                        textColor: green,
                        isBold: true,
                        fontSizesLevel: 1),
                  ),
                  buildTextField(
                      h, w, f, lecturenamecontroller, 'عنوان المحاضرة', false),
                  Container(
                    height: h * 0.02,
                  ),
                  Container(
                    child: text('تفاصيل المحاضرة',
                        fontSize: f,
                        textColor: green,
                        isBold: true,
                        fontSizesLevel: 1),
                  ),
                  buildTextField2(
                      h, w, f, lecturedisccontroller, 'تفاصيل المحاضرة', false),
                  Container(
                    height: h * 0.05,
                  ),
                  InkWell(
                      onTap: () {
                        print('sss');
                        if (lecturenamecontroller.text.isEmpty) {
                          setState(() {
                            showError = true;
                            errorString = "فضلا ادخل عنوان المحاضرة";
                          });
                        } else if (lecturedisccontroller.text.isEmpty) {
                          setState(() {
                            showError = true;
                            errorString = "فضلا ادخل تفاصيل للمحاضرة";
                          });
                          // } else if (classcodeccontroller.text.isEmpty) {
                          //   setState(() {
                          //     showError = true;
                          //     errorString = "فضلا ادخل  كود الانظمام";
                          //   });
                        } else
                          BlocProvider.of<UpdateLectureBloc>(context).add(
                              UpdateLecture(
                                  name: lecturenamecontroller.text,
                                  descr: lecturedisccontroller.text,
                                  id: element.id,
                                  classid: classid));
                      },
                      child: buttons('تعديل', 0, green)),
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
    ));
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
        decoration: boxDecoration(radius: 15, color: blue),
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

  Directionality buildTextField2(double height, double width, double fontx,
      TextEditingController controller, String hint, bool secureWords) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: height * 0.25,
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.only(
            left: width * 0.03, right: width * 0.03, top: height * 0.01),
        decoration: boxDecoration(radius: 15, color: blue),
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
        child: BlocBuilder<UpdateLectureBloc, UpdateLectureState>(
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
}
