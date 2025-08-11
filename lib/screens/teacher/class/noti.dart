import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/teacher/createMessageBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/createMessageBloc/event.dart';
import 'package:alwastia/bloc/teacher/createMessageBloc/state.dart';
import 'package:alwastia/bloc/teacher/getMyClassesBloc/model.dart';
import 'package:alwastia/bloc/teacher/getMyNotiBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyNotiBloc/event.dart';
import 'package:alwastia/bloc/teacher/getMyNotiBloc/state.dart';
import 'package:alwastia/consts.dart';
import 'package:alwastia/widgets/boxdecoration.dart';

class Noti2 extends StatefulWidget {
  late ClassModel element;
  Noti2({required this.element});
  @override
  _Noti2State createState() => _Noti2State(element: element);
}

class _Noti2State extends State<Noti2> with AutomaticKeepAliveClientMixin {
  var contentcontroller = TextEditingController();
  var titleccontroller = TextEditingController();
  late ClassModel element;
  _Noti2State({required this.element});
  List isClicked = [];
  int itemIndex = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetNotiBloc>(context).add(GetMyNotis(classId: element.id));
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double f = w / 25;
    return SafeArea(
      child: BlocListener<GetNotiBloc, GetNotisState>(
        listener: (context, state) => {
          if (state is MyNotis) {isClicked = state.Isclicked}
        },
        child: Scaffold(
          floatingActionButton: floatingActionButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
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
                        "الإشعارات",
                        style: TextStyle(
                            color: color3,
                            fontSize: f + f * 0.4,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  BlocBuilder<GetNotiBloc, GetNotisState>(
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
                    } else if (state is MyNotis) {
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
                                      setState(() {
                                        isClicked[index] = !isClicked[index];
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: h * 0.01),
                                      decoration: BoxDecoration(
                                        color: white,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
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
                                          Container(
                                            child: Center(
                                              child: Icon(
                                                isClicked[index]
                                                    ? Icons.keyboard_arrow_up
                                                    : Icons.keyboard_arrow_down,
                                                size: f * 1.5,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            // height: h * 0.06,
                                            // width: w,
                                            padding: EdgeInsets.only(
                                                right: h * 0.02),
                                            margin:
                                                EdgeInsets.only(top: h * 0.01),
                                            child: Text(state.data[index].name,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: color3,
                                                    fontSize: f)),
                                          ),
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
                                                  color: color3, fontSize: f)),
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
                                      BlocProvider.of<GetNotiBloc>(context)
                                          .add(GetMyNotis(classId: element.id));
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
    );
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
      label: Text("إضافة إشعار"),
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
        child: BlocBuilder<CreateNotiBloc, CreateNotiState>(
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
      heightFactor: 0.7,
      child: StatefulBuilder(builder: (context, StateSetter setSheetState) {
        return BlocListener<CreateNotiBloc, CreateNotiState>(
          listener: (context, state) => {
            if (state is CreateNotiDone)
              {
                if (state.connection)
                  {
                    if (state.res)
                      {
                        BlocProvider.of<GetNotiBloc>(context)
                            .add(GetMyNotis(classId: element.id)),
                        setSheetState(() {
                          contentcontroller.clear();
                          titleccontroller.clear();
                          showError = true;
                          errorString = 'تم إرسال الإشعار  بنجاح';
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
                          h, w, f, titleccontroller, 'عنوان الإشعار', false),
                      Container(
                        height: h * 0.02,
                      ),
                      buildTextField2(
                          h, w, f, contentcontroller, 'محتوى الإشعار', false),
                      Container(
                        height: h * 0.05,
                      ),
                      InkWell(
                          onTap: () {
                            print('sss');
                            if (titleccontroller.text.isEmpty) {
                              setSheetState(() {
                                showError = true;
                                errorString = "فضلا ادخل عنوان الإشعار";
                              });
                            } else if (contentcontroller.text.isEmpty) {
                              setSheetState(() {
                                showError = true;
                                errorString = "فضلا ادخل محتوى الإشعار";
                              });
                            } else
                              BlocProvider.of<CreateNotiBloc>(context).add(
                                  CreateNoti(
                                      name: titleccontroller.text,
                                      detail: contentcontroller.text,
                                      classId: element.id));
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

  @override
  bool get wantKeepAlive => true;
}
