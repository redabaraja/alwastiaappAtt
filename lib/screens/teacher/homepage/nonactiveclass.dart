import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/teacher/createclassBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/createclassBloc/state.dart';
import 'package:alwastia/bloc/teacher/getMyClosingClassesBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyClosingClassesBloc/event.dart';
import 'package:alwastia/bloc/teacher/getMyClosingClassesBloc/state.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/screens/teacher/class/classroom.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';

class NonActiveClasses extends StatefulWidget {
  @override
  State<NonActiveClasses> createState() => _NonActiveClassesState();
}

class _NonActiveClassesState extends State<NonActiveClasses>
    with AutomaticKeepAliveClientMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var classnamecontroller = TextEditingController();
  var classdisccontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetClosingClassesBloc>(context)
        .add(GetMyClosingClasses(status: '-1'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: h * 0.02,
              ),
              Container(
                height: h * 0.6,
                width: w,
                child: Center(
                  child: text('لا توجد مواد غير مفعلة ',
                      fontSize: f,
                      fontSizesLevel: 1,
                      isBold: true,
                      textColor: Colors.black),
                ),
              )
              // listview(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
  Widget listview() {
    return BlocBuilder<GetClosingClassesBloc, GetClassesState2>(
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
      } else if (state is MyClosingClasses) {
        if (state.connection) {
          if (state.data.isEmpty) {
            return Container(
              width: w,
              height: h * 0.8,
              child: Column(
                children: [
                  Spacer(),
                  Container(
                    height: h * 0.35,
                    width: w * 0.55,
                    decoration: boxDecoration(
                        imageExsit: true,
                        bgColor: Colors.transparent,
                        imageAsset: 'assets/images/noclasses.png',
                        boxfit: BoxFit.contain),
                  ),
                  Spacer(),
                ],
              ),
            );
          } else
            return Container(
              width: w,
              height: h * 0.8,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Container(
                      decoration: boxDecoration(radius: 10, showShadow: true),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => ClassRoom(
                                    element: state.data[index],
                                    conxt: context,
                                    isClosing: true,
                                  )));
                        },
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: <Widget>[
                              Container(
                                  width: w / 3,
                                  height: w / 2.8,
                                  decoration: boxDecoration(
                                      radius: 8,
                                      showShadow: true,
                                      imageExsit: true,
                                      imagetype: 0,
                                      boxfit: BoxFit.cover,
                                      imageAsset: 'assets/images/class.png')),
                              Container(
                                width: w - (w / 3) - 35,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            color: blue,
                                            borderRadius: new BorderRadius.only(
                                                bottomRight:
                                                    const Radius.circular(16.0),
                                                topRight: const Radius.circular(
                                                    16.0)),
                                          ),
                                          padding:
                                              EdgeInsets.fromLTRB(8, 2, 8, 2),
                                          child: text('فتح',
                                              textColor: white,
                                              fontSize: f,
                                              fontSizesLevel: 0),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          text(state.data[index].name,
                                              textColor: color3,
                                              fontSize: f * 1.2,
                                              textaligntype: 2,
                                              isBold: true),
                                          SizedBox(height: 4),
                                          // text(
                                          //     "عدد الطلاب: " +
                                          //         state.data[index].stdCount
                                          //             .toString(),
                                          //     fontSize: f,
                                          //     textaligntype: 2,
                                          //     maxLine: 1),
                                          // SizedBox(
                                          //   height: 4,
                                          // ),
                                          // text(state.data[index].date,
                                          //     fontSize: f,
                                          //     textaligntype: 2,
                                          //     maxLine: 1),
                                          SizedBox(height: 4),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          margin: EdgeInsets.all(0),
                        ),
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
                        BlocProvider.of<GetClosingClassesBloc>(context)
                            .add(GetMyClosingClasses(status: '-1'));
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
        child: BlocBuilder<CreateClassBloc, CreateClassState>(
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
