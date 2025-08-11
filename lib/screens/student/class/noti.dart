import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';
import 'package:alwastia/bloc/teacher/getMyNotiBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyNotiBloc/event.dart';
import 'package:alwastia/bloc/teacher/getMyNotiBloc/state.dart';
import 'package:alwastia/consts.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';

class Noti2 extends StatefulWidget {
  late ClassModel2 element;
  Noti2({required this.element});
  @override
  _Noti2State createState() => _Noti2State(element: element);
}

class _Noti2State extends State<Noti2> with AutomaticKeepAliveClientMixin {
  late ClassModel2 element;
  _Noti2State({required this.element});
  List isClicked = [false, false, false];
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
          body: SingleChildScrollView(
            child: Container(
              height: h,
              width: w,
              child: Column(
                children: [
                  Container(
                    height: h * 0.06,
                    width: w,
                    margin: EdgeInsets.only(top:h*0.02,bottom: h*0.02),
                    child: Center(
                      child: text("الإشعارات",
                          fontSize: f,
                          fontSizesLevel: 1,
                          isBold: true,
                          textColor: color3),
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

  @override
  bool get wantKeepAlive => true;
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
}
