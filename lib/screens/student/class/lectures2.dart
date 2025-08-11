import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';
import 'package:alwastia/bloc/teacher/getMyLecturesBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyLecturesBloc/event.dart';
import 'package:alwastia/bloc/teacher/getMyLecturesBloc/state.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';

class Lectures2 extends StatefulWidget {
  late ClassModel2 element;
  Lectures2({required this.element});

  @override
  State<Lectures2> createState() => _Lectures2State(element: element);
}

class _Lectures2State extends State<Lectures2> {
  late ClassModel2 element;
  _Lectures2State({required this.element});
  var titleController = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetLecturesBloc>(context)
        .add(GetMyLectures(classId: element.id));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            height: h * 0.1,
            width: w,
            child: Center(
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: text('المحاضرات',
                      fontSize: f,
                      fontSizesLevel: 1,
                      textColor: color3,
                      isBold: true)),
            ),
          ),
          BlocBuilder<GetLecturesBloc, GetLecturesState>(
              builder: (context, state) {
            if (state is LoadingState2) {
              return Container(
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
              );
            } else if (state is MyLectures) {
              if (state.connection) {
                return Container(
                  height: h * 0.8,
                  width: w * 0.9,
                  child: ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                        
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
                                    imageAsset: 'assets/images/lecture.png'),
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
                              BlocProvider.of<GetLecturesBloc>(context)
                                  .add(GetMyLectures(classId: element.id));
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
          }),
        ],
      ),
    ));
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
          )),
    );
  }
}
