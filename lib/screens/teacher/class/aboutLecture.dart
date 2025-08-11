import 'package:flutter/services.dart';
import 'package:alwastia/bloc/teacher/getMyLecturesBloc/model.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/screens/teacher/class/updateLectureInfo.dart';

class AboutLecture extends StatefulWidget {
  late LectureModel element;
  late int classid;
  AboutLecture({required this.element, required this.classid});
  @override
  State<AboutLecture> createState() =>
      _AboutLectureState(element: element, classid: classid);
}

class _AboutLectureState extends State<AboutLecture>
    with AutomaticKeepAliveClientMixin {
  late LectureModel element;
  late int classid;
  _AboutLectureState({required this.element, required this.classid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 16, top: 20, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              infoline("اسم المحاظرة", element.name),
              spaceBetweenBtns(),
              infoline("الوصف", element.descr),
              Container(
                height: h * 0.05,
              ),
              spaceBetweenBtns(),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => UpdateLectureInfo(
                              element: element,
                              classid: classid,
                            )));
                  },
                  child: buttons('تعديل بيانات المحاظرة', 0, green)),
              spaceBetweenBtns(),
              buttons('حذف المحاظرة', 0, Colors.red.shade300),
            ],
          ),
        ),
      ),
    );
  }

  Container spaceBetweenBtns() {
    return Container(
      height: h * 0.01,
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
        child: Center(
          child: Text(txt,
              style: TextStyle(
                  fontSize: f, fontWeight: FontWeight.bold, color: white)),
        ),
      ),
    );
  }

  Container infoline(String key, String value) {
    return Container(
      // height: h * 0.08,
      width: w,
      color: white,
      child: Row(
        children: [
          Container(
            width: w * 0.6,
            child: Center(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(value,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: f,
                        fontWeight: FontWeight.bold,
                        color: color3)),
              ),
            ),
          ),
          Container(
            width: w * 0.3,
            child: Center(
              child: Text(key,
                  style: TextStyle(
                      fontSize: f, fontWeight: FontWeight.bold, color: color3)),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
