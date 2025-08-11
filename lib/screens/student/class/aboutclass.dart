import 'package:alwastia/screens/student/class/stdAttendance.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';
import 'package:flutter/services.dart';
import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/geLinkedClassesBloc/bloc.dart';
import 'package:alwastia/bloc/student/geLinkedClassesBloc/event.dart';
import 'package:alwastia/bloc/student/geLinkedClassesBloc/state.dart';

class AboutClass extends StatefulWidget {
  late ClassModel2 element;
  AboutClass({required this.element});
  @override
  State<AboutClass> createState() => _AboutClassState(element: element);
}

class _AboutClassState extends State<AboutClass> {
  late ClassModel2 element;
  _AboutClassState({required this.element});
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetLinkedClassesBloc>(context).add(GetLinkedClasses());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 16, top: 20, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<GetLinkedClassesBloc, GetLinkedClassesState>(
                  builder: (context, state) {
                if (state is LoadingState2) {
                  return Container(
                      height: h * 0.5,
                      width: w,
                      child: Center(
                        child: Container(
                          height: h * 0.03,
                          width: h * 0.03,
                          child: CircularProgressIndicator(
                            color: blue,
                            strokeWidth: 2,
                          ),
                        ),
                      ));
                } else if (state is MyLinkedClasses) {
                  if (state.connection) {
                    if (state.data.isEmpty) {
                      return Container(
                        height: h * 0.5,
                        width: w,
                        child: Center(
                          child: text('الطالب غير مرتبط باي مواد',
                              fontSize: f,
                              fontSizesLevel: 0,
                              isBold: true,
                              textColor: Colors.black),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: state.data.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      StdAttendance(
                                          element: state.data[index])));
                            },
                            child: Container(
                              height: h * 0.07,
                              width: w,
                              margin: EdgeInsets.all(5),
                              decoration: boxDecoration(
                                radius: 10,
                                bgColor: white,
                                showShadow: true,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: text(state.data[index].name,
                                          fontSize: f,
                                          fontSizesLevel: 0,
                                          isBold: true,
                                          textColor: blue.withOpacity(0.8)),
                                    ),
                                  ),
                                  Container(
                                    height: h * 0.07,
                                    width: w * 0.15,
                                    decoration: BoxDecoration(
                                        image: state.data[index].image.isEmpty
                                            ? DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/class.png'),
                                                fit: BoxFit.fill)
                                            : DecorationImage(
                                                image: NetworkImage(baseUrl3 +
                                                    '/' +
                                                    state.data[index].image),
                                                fit: BoxFit.cover),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10))),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  } else {
                    return Container(
                      height: h * 0.5,
                      width: w,
                      child: Center(
                        child: text('لا يوجد أتصال بالانترنت',
                            fontSize: f,
                            fontSizesLevel: 0,
                            isBold: true,
                            textColor: Colors.black),
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
}
