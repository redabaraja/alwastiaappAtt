import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';

import 'package:alwastia/bloc/student/getStdSemesters/bloc.dart';
import 'package:alwastia/bloc/student/getStdSemesters/event.dart';
import 'package:alwastia/bloc/student/getStdSemesters/state.dart';
import 'package:alwastia/bloc/teacher/getStudentsMarks/bloc.dart';
import 'package:alwastia/bloc/teacher/getStudentsMarks/state.dart';
import 'package:alwastia/bloc/teacher/getStudentsMarks/event.dart';

import 'package:alwastia/consts.dart';
import 'package:alwastia/screens/student/class/stdAttendance.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarksMenu extends StatefulWidget {
  late ClassModel2 element;
  MarksMenu({required this.element});
  @override
  State<MarksMenu> createState() => _MarksMenuState(element: element);
}

class _MarksMenuState extends State<MarksMenu> {
  late ClassModel2 element;
  _MarksMenuState({required this.element});
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetStdSemestersBloc>(context).add(GetStdSemesters());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BlocBuilder<GetStdSemestersBloc, GetStdSemestersState>(
                  builder: (context, state) {
                if (state is LoadingState2) {
                  return Container(
                    height: h * 0.3,
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
                    ),
                  );
                } else if (state is MySemesters) {
                  if (state.data.isEmpty) {
                    return Container(
                      height: h * 0.3,
                      width: w,
                      child: Center(
                          child: text('لا توجد اي فصول دراسية مضافة',
                              fontSize: f,
                              fontSizesLevel: 0,
                              isBold: true,
                              textColor: color3)),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: state.data.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            showCustomBottomSheet(context,
                                state.data[index].name, state.data[index].id);
                          },
                          child: Container(
                            height: h * 0.06,
                            width: w,
                            margin: EdgeInsets.only(
                                left: w * 0.07, right: w * 0.07, top: h * 0.02),
                            decoration: boxDecoration(
                                radius: 10, bgColor: blue, showShadow: true),
                            child: Row(children: [
                              Container(
                                width: w * 0.03,
                              ),
                              Icon(
                                Icons.arrow_back,
                                color: white,
                                size: f * 1.3,
                              ),
                              Spacer(),
                              text(state.data[index].name,
                                  fontSize: f,
                                  fontSizesLevel: -1,
                                  isBold: true,
                                  textColor: white),
                              Spacer()
                            ]),
                          ),
                        );
                      },
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

  Widget menuItem2(String txt, String img) {
    return Container(
      height: h * 0.13,
      width: w * 0.4,
      decoration: boxDecoration(
        showShadow: true,
        radius: 10,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: h * 0.1,
              width: w * 0.4,
              decoration: boxDecoration(
                  imageExsit: true, imageAsset: img, boxfit: BoxFit.contain),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: h * 0.03,
              width: w * 0.4,
              decoration: BoxDecoration(
                  color: color3.withOpacity(0.3),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Center(
                child: text(txt,
                    fontSize: f,
                    fontSizesLevel: 0,
                    textColor: white,
                    isBold: true),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showCustomBottomSheet(BuildContext context, String title, int semId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return MySheet(semId: semId, title: title);
      },
    );
  }

  Container menuItem(String name) {
    return Container(
      height: h * 0.05,
      width: w,
      child: Row(
        children: <Widget>[
          Container(
            width: w * 0.15,
          ),
          Icon(
            Icons.arrow_back_ios,
            size: f,
            color: blue,
          ),
          Spacer(),
          Container(
            height: h * 0.07,
            child: Center(
              child:
                  text(name, fontSize: f, fontSizesLevel: 0, textColor: blue),
            ),
          ),
          Container(
            width: w * 0.1,
          ),
        ],
      ),
    );
  }

  Container line() {
    return Container(
      height: 1,
      color: blue.withOpacity(0.2),
    );
  }
}

class MySheet extends StatefulWidget {
  late String title;
  late int semId;
  MySheet({required this.semId, required this.title});

  @override
  State<MySheet> createState() => _MySheetState(semId: semId, title: title);
}

class _MySheetState extends State<MySheet> {
  late String title;
  late int semId;
  _MySheetState({required this.title, required this.semId});

  int selected = 0;
  List<String> head = [
    'المادة',
    'الشهر الاول',
    'الشهر الثاني',
    'عملي1',
    'عملي2',
    'ملاحظات'
  ];
  List<String> head2 = [
    'المادة',
    'المحصلة الشهرية',
    'الامتحان النهائي',
    'المجموع',
  ];
  List<String> subjects = [
    'القران الكريم',
    'التربية الاسلامية',
    'اللغة العربية',
    'الرياضيات',
    'العلوم الانسانية',
    'المنطق',
    'اللغة الانجليزية',
    'العلوم البيئية',
    'الحوسبة',
    'علم الهلوسة',
    'الجبر'
  ];
  List<List<String>> results = [
    ['القران الكريم', '12', '33', '44', '0', 'انتبه لنفسك ايها الطالب المشاكس'],
    [
      'التربية الاسلامية',
      '12',
      '33',
      '44',
      '0',
      'انتبه لنفسك ايها الطالب المشاكس'
    ],
    ['اللغة العربية', '12', '33', '44', '0', 'انتبه لنفسك ايها الطالب المشاكس'],
    ['الراضيات', '12', '33', '44', '0', 'انتبه لنفسك ايها الطالب المشاكس'],
    [
      'العلوم الانسانية',
      '12',
      '33',
      '44',
      '0',
      'انتبه لنفسك ايها الطالب المشاكس'
    ],
    ['المنطق', '12', '33', '44', '0', 'انتبه لنفسك ايها الطالب المشاكس'],
    ['العلوم البئية', '12', '33', '44', '0', 'انتبه لنفسك ايها الطالب المشاكس'],
    ['الجوراسيك', '12', '33', '44', '0', 'انتبه لنفسك ايها الطالب المشاكس'],
    ['الحوسبة', '12', '33', '44', '0', 'انتبه لنفسك ايها الطالب المشاكس'],
    ['الجبر', '12', '33', '44', '0', 'انتبه لنفسك ايها الطالب المشاكس'],
    ['الهندسة', '12', '33', '44', '0', 'انتبه لنفسك ايها الطالب المشاكس'],
  ];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetMarksBloc>(context).add(GetMarks(semesterId: semId));
  }

  @override
  Widget build(BuildContext context) {
    print('it is printed');
    return Container(
      height: h * 0.8,
      width: w, // Set the desired height
      padding: EdgeInsets.all(16.0),
      child:
          BlocBuilder<GetMarksBloc, GetMarksState>(builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: Container(
              height: h * 0.03,
              width: h * 0.03,
              child: CircularProgressIndicator(
                color: blue,
                strokeWidth: 2,
              ),
            ),
          );
        } else if (state is GetMarksDone) {
          if (state.data == null) {
            return Center(
              child: text('لا توجد نتائج',
                  fontSize: f,
                  fontSizesLevel: 0,
                  isBold: true,
                  textColor: blue),
            );
          } else {
            return Column(
              children: [
                // Add your custom content here
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold, color: blue),
                ),
                Container(
                  height: h * 0.1,
                  width: w,
                  child: Column(
                    children: [
                      Spacer(),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          text(state.data!.grade,
                              fontSize: f,
                              fontSizesLevel: 0,
                              isBold: true,
                              textColor: color3),
                          text(' : ',
                              fontSize: f,
                              fontSizesLevel: 0,
                              isBold: true,
                              textColor: blue),
                          text('التقدير',
                              fontSize: f,
                              fontSizesLevel: 0,
                              isBold: true,
                              textColor: blue),
                          Spacer(),
                          text(state.data!.total.toString(),
                              fontSize: f,
                              fontSizesLevel: 0,
                              isBold: true,
                              textColor: color3),
                          text(' : ',
                              fontSize: f,
                              fontSizesLevel: 0,
                              isBold: true,
                              textColor: blue),
                          text('المجموع',
                              fontSize: f,
                              fontSizesLevel: 0,
                              isBold: true,
                              textColor: blue),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Spacer(),
                          text(state.data!.note,
                              fontSize: f,
                              fontSizesLevel: 0,
                              isBold: true,
                              textColor: color3),
                          text(' : ',
                              fontSize: f,
                              fontSizesLevel: 0,
                              isBold: true,
                              textColor: blue),
                          text('الحالة',
                              fontSize: f,
                              fontSizesLevel: 0,
                              isBold: true,
                              textColor: blue),
                          Spacer()
                        ],
                      ),
                      Spacer()
                    ],
                  ),
                ),
                SizedBox(height: 7.0),
                Container(
                  height: h * 0.07,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selected = 1;
                            });
                          },
                          child: Container(
                            height: selected == 1 ? h * 0.07 : h * 0.055,
                            decoration: boxDecoration(
                                radius: 5,
                                showShadow: true,
                                bgColor: selected == 1
                                    ? blue.withOpacity(0.7)
                                    : white),
                            child: Center(
                              child: text('أعمال الفصل',
                                  fontSize: f,
                                  fontSizesLevel: -1,
                                  isBold: true,
                                  textColor: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selected = 0;
                            });
                          },
                          child: Container(
                            height: selected == 0 ? h * 0.07 : h * 0.055,
                            decoration: boxDecoration(
                                radius: 5,
                                bgColor: selected == 0
                                    ? blue.withOpacity(0.7)
                                    : white),
                            child: Center(
                              child: text('الامتحان الشهري',
                                  fontSize: f,
                                  fontSizesLevel: -1,
                                  isBold: true,
                                  textColor: Colors.black),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 10,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    height: h * 0.52,
                    width: w,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          selected == 1
                              ? Row(
                                  children: List.generate(
                                    head2.length,
                                    (index) => Container(
                                      width: index == 0 ? 200 : 150,
                                      height: 50.0,
                                      decoration: boxDecoration(
                                          color: white.withOpacity(0.3),
                                          bgColor: blue.withOpacity(0.7)),
                                      child: Center(
                                        child: Text(
                                          head2[index],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Row(
                                  children: List.generate(
                                    head.length,
                                    (index) => Container(
                                      width: index == 0
                                          ? 200
                                          : index == head.length - 1
                                              ? 200
                                              : 100.0,
                                      height: 50.0,
                                      decoration: boxDecoration(
                                          color: white.withOpacity(0.3),
                                          bgColor: blue.withOpacity(0.7)),
                                      child: Center(
                                        child: Text(
                                          head[index],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                          // SizedBox(height: 10.0),
                          selected == 1
                              ? Container(
                                  width:
                                      650.0, // Set a fixed width for the content
                                  height: 360.0,
                                  child: ListView.builder(
                                    itemCount: state.data!.marksData.length,
                                    itemBuilder: (context, index) {
                                      List<String> rowData = [
                                        state.data!.marksData[index].classnName,
                                        state.data!.marksData[index]
                                            .monthlyTotalMark
                                            .toString(),
                                        state.data!.marksData[index].finalMark
                                            .toString(),
                                        (state.data!.marksData[index]
                                                    .monthlyTotalMark +
                                                state.data!.marksData[index]
                                                    .finalMark)
                                            .toString()
                                      ];

                                      return Row(
                                        children: List.generate(
                                          rowData.length,
                                          (index2) => Container(
                                            width: index2 == 0 ? 200 : 150,
                                            height: 45.0,
                                            decoration: boxDecoration(
                                                color: blue.withOpacity(0.1)),
                                            child: Center(
                                              child: InkWell(
                                                onTap: () {
                                                  if (index2 == 0) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return textDialog(
                                                            rowData[index2]);
                                                      },
                                                    );
                                                  }
                                                },
                                                child: Text(
                                                  rowData[index2],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Container(
                                  width:
                                      800.0, // Set a fixed width for the content
                                  height: 360.0,
                                  child: ListView.builder(
                                    itemCount: state.data!.marksData.length,
                                    itemBuilder: (context, index) {
                                      List<String> rowData = [
                                        state.data!.marksData[index].classnName,
                                        state.data!.marksData[index]
                                            .firstMonthTheory
                                            .toString(),
                                        state.data!.marksData[index]
                                            .secondMonthTheory
                                            .toString(),
                                        state.data!.marksData[index]
                                            .firstMonthPractical
                                            .toString(),
                                        state.data!.marksData[index]
                                            .secondMonthPractical
                                            .toString(),
                                        ''
                                      ];

                                      return Row(
                                        children: List.generate(
                                          rowData.length,
                                          (index2) => Container(
                                            width: index2 == 0
                                                ? 200
                                                : index2 == head.length - 1
                                                    ? 200
                                                    : 100.0,
                                            height: 45.0,
                                            decoration: boxDecoration(
                                                color: blue.withOpacity(0.1)),
                                            child: Center(
                                              child: InkWell(
                                                onTap: () {
                                                  if (index2 == 0) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return textDialog(
                                                            rowData[index2]);
                                                      },
                                                    );
                                                  }
                                                },
                                                child: Text(
                                                  rowData[index2],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                )
                // Add more widgets as needed
              ],
            );
          }
        } else {
          return Container();
        }
      }),
    );
  }

  textDialog(String text) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              child: Text('إغلاق'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
