import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';
import 'package:alwastia/bloc/student/uploadhomeworkbloc/bloc.dart';
import 'package:alwastia/bloc/student/uploadhomeworkbloc/event.dart';
import 'package:alwastia/bloc/student/uploadhomeworkbloc/state.dart';
import 'package:alwastia/bloc/teacher/gethomeworks2/bloc.dart';
import 'package:alwastia/bloc/teacher/gethomeworks2/event.dart';
import 'package:alwastia/bloc/teacher/gethomeworks2/state.dart';
import 'package:alwastia/consts.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class HomeWork extends StatefulWidget {
  late ClassModel2 element;
  HomeWork({required this.element});
  @override
  _HomeWorkState createState() => _HomeWorkState(element: element);
}

class _HomeWorkState extends State<HomeWork>
    with AutomaticKeepAliveClientMixin {
  var contentcontroller = TextEditingController();
  var titleccontroller = TextEditingController();
  List<int> homeworkstate = [1, 2, 0];
  late ClassModel2 element;
  _HomeWorkState({required this.element});
  List isClicked = [];
  int itemIndex = 0;
  DateTime date = new DateTime.now();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String datehint = 'تاريخ  اخر تسليم';
  bool dateSelected = false;
  int cindex = 0;
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetHomeWorkBloc2>(context)
        .add(GetMyHomeWorks2(classId: element.id));
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double f = w / 25;
    return SafeArea(
      child: BlocListener<GetHomeWorkBloc2, GetHomeWorkState2>(
        listener: (context, state) => {
          if (state is MyHomeWork) {isClicked = state.Isclicked}
        },
        child: BlocListener<UploadHomeWorkBloc, UploadHomeWorkState>(
          listener: (context, state) => {
            if (state is GetFileDone)
              {
                BlocProvider.of<UploadHomeWorkBloc>(context).add(UploadHomeWork(
                    file: File(state.filePath),
                    assignmentId: state.assignment)),
                setState(() {
                  isUploading = true;
                  cindex = state.index;
                })
              }
            else if (state is UploadHomeWorkDone)
              {
                if (state.connection)
                  {
                    setState(() {
                      isUploading = false;
                      cindex = 0;
                    }),
                    BlocProvider.of<GetHomeWorkBloc2>(context)
                        .add(GetMyHomeWorks2(classId: element.id)),
                    // scaffoldKey.currentState?.showSnackBar(bildSnacbar(
                    //     Text(
                    //       'تم رفع الملف بنجاح',
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         color: blue,
                    //         fontFamily: 'DroidArabicKufi',
                    //         fontSize: f,
                    //       ),
                    //       textAlign: TextAlign.center,
                    //     ),
                    //     w,
                    //     h,
                    //     blue))
                  }
              }
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: h,
                width: w,
                child: Column(
                  children: [
                    Container(
                      height: h * 0.1,
                      color: white,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Center(
                        child: Text(
                          "الواجبات",
                          style: TextStyle(
                              color: color3,
                              fontSize: f + f * 0.4,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    BlocBuilder<GetHomeWorkBloc2, GetHomeWorkState2>(
                        builder: (context, state) {
                      if (state is LoadingState2) {
                        print('it should be loading now 22');

                        return Container(
                          width: w,
                          height: h * 0.4,
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
                      } else if (state is MyHomeWork) {
                        if (state.connection) {
                          return Container(
                            height: h * 0.8,
                            width: w,
                            child: ListView.builder(
                              itemCount: state.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // setState(() {
                                        //   isClicked[index] = !isClicked[index];
                                        // });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: h * 0.03),
                                        decoration: BoxDecoration(
                                          color: white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                spreadRadius: 1,
                                                blurRadius: 2,
                                                offset: Offset(0, -2))
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: w * 0.05,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  isClicked[index] =
                                                      !isClicked[index];
                                                });
                                              },
                                              child: Container(
                                                child: Center(
                                                  child: Icon(
                                                    isClicked[index]
                                                        ? Icons
                                                            .keyboard_arrow_up
                                                        : Icons
                                                            .keyboard_arrow_down,
                                                    size: f * 1.5,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 7,
                                            ),
                                            Container(
                                              // height: h * 0.06,
                                              // width: w,
                                              padding: EdgeInsets.only(
                                                  right: h * 0.02),
                                              margin: EdgeInsets.only(
                                                  top: h * 0.01),
                                              child: Column(
                                                children: [
                                                  Text('اخر تسليم',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                          color: color3,
                                                          fontSize: f * 0.8)),
                                                  Text(state.data[index].date,
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                          color: color3,
                                                          fontSize: f * 0.8)),
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              // height: h * 0.06,
                                              // width: w,
                                              padding: EdgeInsets.only(
                                                  right: h * 0.02),
                                              margin: EdgeInsets.only(
                                                  top: h * 0.01),
                                              child: Text(
                                                  state.data[index].name,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      color: color3,
                                                      fontSize: f)),
                                            ),
                                            Container(
                                              height: h * 0.08,
                                              width: h * 0.08,
                                              decoration: boxDecoration(
                                                  radius: 100,
                                                  imageExsit: true,
                                                  boxfit: BoxFit.fill,
                                                  imageAsset:
                                                      'assets/images/homework.png'),
                                            ),
                                            Container(
                                              width: 10,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    !isClicked[index]
                                        ? Container()
                                        : Container(
                                            // height: h * 0.06,
                                            width: w,
                                            decoration: BoxDecoration(
                                              color: white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    spreadRadius: 1,
                                                    blurRadius: 2,
                                                    offset: Offset(0, 2))
                                              ],
                                            ),
                                            padding: EdgeInsets.only(
                                                right: h * 0.02,
                                                top: h * 0.02,
                                                bottom: h * 0.02,
                                                left: h * 0.03),
                                            // margin: EdgeInsets.only(top: h * 0.01),
                                            child: Text(
                                                state.data[index].descr == null
                                                    ? ''
                                                    : state.data[index].descr,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: color3,
                                                    fontSize: f)),
                                          ),
                                    checkHomeWorkState(state.data[index].date,
                                                state.data[index].status) ==
                                            2
                                        ? Container(
                                            height: h * 0.06,
                                            width: w,
                                            child: Center(
                                              child: Container(
                                                width: w * 0.95,
                                                decoration: boxDecoration(
                                                    radius: 5,
                                                    bgColor:
                                                        Colors.red.shade300),
                                                child: Center(
                                                  child: text(
                                                      'إنتهى وقت التسليم',
                                                      fontSize: f,
                                                      fontSizesLevel: 0,
                                                      isBold: true,
                                                      textColor: white),
                                                ),
                                              ),
                                            ),
                                          )
                                        : checkHomeWorkState(
                                                    state.data[index].date,
                                                    state.data[index].status) ==
                                                0
                                            ? InkWell(
                                                onTap: () {
                                                  BlocProvider.of<
                                                              UploadHomeWorkBloc>(
                                                          context)
                                                      .add(GetFileForUpload(
                                                          assignment: state
                                                              .data[index].id,
                                                          index: index));
                                                },
                                                child: Container(
                                                  height: h * 0.06,
                                                  width: w,
                                                  child: Center(
                                                    child: Container(
                                                      width: w * 0.95,
                                                      decoration: boxDecoration(
                                                          radius: 5,
                                                          bgColor: blue),
                                                      child: (isUploading &&
                                                              index == cindex)
                                                          ? Center(
                                                              child: Container(
                                                                height:
                                                                    h * 0.03,
                                                                width: h * 0.03,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color: white,
                                                                  strokeWidth:
                                                                      2,
                                                                ),
                                                              ),
                                                            )
                                                          : Center(
                                                              child: text(
                                                                  'رفع ملف',
                                                                  fontSize: f,
                                                                  fontSizesLevel:
                                                                      0,
                                                                  isBold: true,
                                                                  textColor:
                                                                      white),
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                 
                                                },
                                                child: Container(
                                                  height: h * 0.06,
                                                  width: w,
                                                  child: Center(
                                                    child: Container(
                                                      width: w * 0.95,
                                                      decoration: boxDecoration(
                                                          radius: 5,
                                                          bgColor: green),
                                                      child: Center(
                                                        child: text(
                                                            'تم رفع الملف',
                                                            fontSize: f,
                                                            fontSizesLevel: 0,
                                                            isBold: true,
                                                            textColor: white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                  ],
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
                                        BlocProvider.of<GetHomeWorkBloc2>(
                                                context)
                                            .add(GetMyHomeWorks2(
                                                classId: element.id));
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
              ),
            ),
          ),
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
        child: Center(
          child: Text(txt,
              style: TextStyle(
                  fontSize: f, fontWeight: FontWeight.bold, color: white)),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  checkHomeWorkState(String date, bool status) {
    DateTime rowdate = DateTime.now();
    String cdate = rowdate.month.toString() +
        '/' +
        rowdate.day.toString() +
        '/' +
        rowdate.year.toString();
    if (status) {
      return 1;
    } else if (convertDatetoDays(date) < convertDatetoDays(cdate)) {
      return 2;
    } else if (convertDatetoDays(date) > convertDatetoDays(cdate)) {
      return 0;
    } else {
      return 0;
    }
  }

  convertDatetoDays(String date) {
    List data = date.split('/');
    int days = (int.parse(data[0]) * 30) +
        (int.parse(data[1])) +
        (int.parse(data[2]) * 12 * 30);
    return days;
  }

  bildSnacbar(Widget text, double width, double height, Color color) {
    return SnackBar(
      content: text,
      backgroundColor: color.withOpacity(.8),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        left: width * .05,
        right: width * .05,
        bottom: height * 0.8,
      ),
      padding:
          EdgeInsets.symmetric(horizontal: width * .04, vertical: width * .01),
    );
  }
}
