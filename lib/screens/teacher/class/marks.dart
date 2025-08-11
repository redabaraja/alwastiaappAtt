import 'package:alwastia/bloc/teacher/getAllStdMarks/event.dart';
import 'package:alwastia/bloc/teacher/getAllStdMarks/model.dart';
import 'package:alwastia/bloc/teacher/getAllStdMarks/state.dart';
import 'package:alwastia/bloc/teacher/getAllStdMarks/bloc.dart';
import 'package:alwastia/bloc/teacher/saveResultBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/saveResultBloc/event.dart';
import 'package:alwastia/bloc/teacher/saveResultBloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:alwastia/bloc/teacher/getMyClassesBloc/model.dart';

import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';

class Marks extends StatefulWidget {
  late ClassModel element;
  Marks({required this.element});

  @override
  State<Marks> createState() => _MarksState(element: element);
}

class _MarksState extends State<Marks> {
  late ClassModel element;
  _MarksState({required this.element});
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetAllStdMarksBloc>(context)
        .add(GetAllStdMarks(classId: element.id));
  }

  int itemindexforClosing = 0;
  List<bool> stdState = [];
  List<String> items1 = [
    'الشهر الاول',
    'الشهر الثاني',
    'عملي 1',
    'عملي 2',
    'الفصلي نظري',
    'الفصلي عملي '
  ];
  bool isEnable = true;
  int selected = 0;
  String selected1 = 'الشهر الاول';
  List<TextEditingController> editors = [];
  List<String> firstMonth = [];
  List<String> secondMonth = [];
  List<String> finalMonth = [];
  List<String> firstMonth2 = [];
  List<String> secondMonth2 = [];
  List<String> finalMonth2 = [];
  List<MarksModel> data = [];
  addItemsToEditors(List<String> d) {
    for (var i = 0; i < d.length; i++) {
      editors[i].text = d[i];
    }

    print(editors[0].text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h * 0.7,
      width: w,
      child: BlocListener<SaveResultBloc, SaveResultState>(
        listener: (context, state) => {
          if (state is SaveDone)
            {
              if (state.res)
                {showErrorDialog(context, 'تم الحفظ', blue)}
              else
                {
                  showErrorDialog(
                      context, 'حصل خطا في الحفظ', Colors.red.shade300)
                }
            }
        },
        child: BlocListener<GetAllStdMarksBloc, GetAllStdMarksState>(
          listener: (context, state) => {
            if (state is GetAllSTdMarksDone)
              {
                data = state.data,
                for (int i = 0; i < state.data.length; i++)
                  {
                    editors.add(TextEditingController()),
                    editors[i].text = state.data[i].firstMonthTheory.toString(),
                    firstMonth.add(state.data[i].firstMonthTheory.toString()),
                    secondMonth.add(state.data[i].secondMonthTheory.toString()),
                    finalMonth
                        .add(state.data[i].degreeOfFinalTheory.toString()),
                    firstMonth2
                        .add(state.data[i].firstMonthPractical.toString()),
                    secondMonth2
                        .add(state.data[i].secondMonthPractical.toString()),
                    finalMonth2
                        .add(state.data[i].degreeOfFinalPractice.toString()),
                  },
                setState(() {})
              }
          },
          child: BlocBuilder<GetAllStdMarksBloc, GetAllStdMarksState>(
              builder: (context, state) {
            String stdCount = '';
            if (state is GetAllSTdMarksDone) {
              stdCount = state.data.length.toString();
            }
            return Column(
              children: [
                Container(
                  height: h * 0.1,
                  width: w,
                  child: Row(
                    children: [
                      Container(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          for (var i = 0; i < data.length; i++) {
                            data[i].firstMonthTheory = int.parse(
                                firstMonth[i].isEmpty ? '0' : firstMonth[i]);
                            data[i].firstMonthPractical = int.parse(
                                firstMonth2[i].isEmpty ? '0' : firstMonth2[i]);
                            data[i].secondMonthTheory = int.parse(
                                secondMonth[i].isEmpty ? '0' : secondMonth[i]);
                            data[i].secondMonthPractical = int.parse(
                                secondMonth2[i].isEmpty
                                    ? '0'
                                    : secondMonth2[i]);
                          }
                          BlocProvider.of<SaveResultBloc>(context).add(
                              SaveResult(
                                  data: data, classId: element.id.toString()));
                        },
                        child: Container(
                          height: h * 0.05,
                          width: w * 0.3,
                          decoration: boxDecoration(radius: 10, bgColor: blue),
                          child: BlocBuilder<SaveResultBloc, SaveResultState>(
                              builder: (context, state) {
                            return state is LoadingState2
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
                                    child: text('حفظ',
                                        fontSize: f,
                                        fontSizesLevel: -1,
                                        isBold: true,
                                        textColor: white),
                                  );
                          }),
                        ),
                      ),
                      Spacer(),
                      Directionality(
                          textDirection: TextDirection.rtl,
                          child: text(('الدرجات'),
                              fontSize: f,
                              fontSizesLevel: 1,
                              textColor: blue,
                              isBold: true)),
                      Container(
                        width: 15,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: h * 0.07,
                  width: w,
                  padding: EdgeInsets.only(bottom: h * 0.01, top: h * 0.01),
                  child: ListView.builder(
                    itemCount: items1.length,
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selected = index;
                            if (index == 0) {
                              print('first');
                              setState(() {
                                isEnable = true;
                              });
                              addItemsToEditors(firstMonth);
                            } else if (index == 1) {
                              print('second');
                              setState(() {
                                isEnable = true;
                              });
                              addItemsToEditors(secondMonth);
                            } else if (index == 2) {
                              print('first,onth2');
                              setState(() {
                                isEnable = true;
                              });
                              addItemsToEditors(firstMonth2);
                            } else if (index == 3) {
                              print('secondmonth2');
                              setState(() {
                                isEnable = true;
                              });
                              addItemsToEditors(secondMonth2);
                            } else if (index == 4) {
                              print('first');
                              setState(() {
                                isEnable = true;
                              });
                              addItemsToEditors(finalMonth);
                            } else if (index == 5) {
                              print('first');
                              setState(() {
                                isEnable = true;
                              });
                              addItemsToEditors(finalMonth2);
                            }
                          });
                     
                        },
                        child: Container(
                          height: h * 0.06,
                          margin: EdgeInsets.only(left: 5, right: 5),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: selected == index
                                ? blue.withOpacity(0.6)
                                : white.withOpacity(0.6),
                            border: Border.all(color: blue.withOpacity(0.4)),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: blue.withOpacity(0.1),
                                spreadRadius:
                                    1, // Controls the spread of the shadow
                                blurRadius: 1,
                                offset: Offset(0,
                                    0), // Offset of (0, 0) creates a shadow around all sides
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              text(items1[index],
                                  textColor:
                                      selected == index ? white : Colors.black,
                                  fontSize: f,
                                  fontSizesLevel: -1,
                                  isBold: true),
                              Container(
                                width: 7,
                              ),
                              Icon(
                                Icons.menu_book,
                                color: selected == index ? white : blue,
                                size: 25,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                state is LoadingState
                    ? Expanded(
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
                      )
                    : state is GetAllSTdMarksDone
                        ? state.data.isEmpty
                            ? Expanded(
                                child: Center(
                                  child: text('لا يوجد طلاب في هذا المقرر بعد',
                                      fontSize: f,
                                      fontSizesLevel: 1,
                                      isBold: true,
                                      textColor: Colors.black),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: state.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            height: h * 0.12,
                                            width: w,
                                            child: Row(
                                              children: [
                                                Spacer(),
                                                Container(
                                                  height: h * 0.12,
                                                  width: w * 0.6,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: Column(
                                                      children: [
                                                        Spacer(),
                                                        Container(
                                                          width: w * 0.6,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: text(
                                                              state.data[index]
                                                                  .studentName,
                                                              fontSize: f,
                                                              fontSizesLevel: 1,
                                                              isBold: true,
                                                              textaligntype: 2,
                                                              textColor:
                                                                  color3),
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          width: w * 0.6,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Row(
                                                            children: [
                                                              text(" الدرجة: ",
                                                                  fontSize: f,
                                                                  fontSizesLevel:
                                                                      0,
                                                                  textColor:
                                                                      color3),
                                                              Container(
                                                                width: w * 0.4,
                                                                height:
                                                                    h * 0.06,
                                                                child: buildTextField(
                                                                    h,
                                                                    w,
                                                                    f,
                                                                    editors[
                                                                        index],
                                                                    '',
                                                                    false,
                                                                    index),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Spacer()
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: w * 0.04,
                                                ),
                                                Container(
                                                  height: h * 0.12,
                                                  width: w * 0.2,
                                                  child: Center(
                                                      child: state.data[index]
                                                                  .picture ==
                                                              ''
                                                          ? Container(
                                                              height: h * 0.08,
                                                              width: h * 0.08,
                                                              decoration: boxDecoration(
                                                                  radius: 100,
                                                                  color: blue,
                                                                  imageExsit:
                                                                      true,
                                                                  boxfit: BoxFit
                                                                      .cover,
                                                                  imageAsset:
                                                                      'assets/images/person.png'),
                                                            )
                                                          : Container(
                                                              height: h * 0.08,
                                                              width: h * 0.08,
                                                              decoration: boxDecoration(
                                                                  radius: 100,
                                                                  color: blue,
                                                                  boxfit: BoxFit
                                                                      .cover,
                                                                  imageExsit:
                                                                      true,
                                                                  imagetype: 1,
                                                                  imageUrl: baseUrl3 +
                                                                      '/' +
                                                                      state
                                                                          .data[
                                                                              index]
                                                                          .picture),
                                                            )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: color3.withOpacity(0.1),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              )
                        : Container(),
                Container(
                  height: 5,
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Directionality buildTextField(
      double height,
      double width,
      double fontx,
      TextEditingController controller,
      String hint,
      bool secureWords,
      int index) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: height * 0.07,
        padding: EdgeInsets.only(top: 14),
        margin: EdgeInsets.only(
            left: width * 0.03, right: width * 0.03, top: height * 0.01),
        decoration: boxDecoration(radius: 15, color: green),
        child: TextField(
          controller: controller,
          maxLines: 1,
          minLines: 1,
          onChanged: (v) {
            int a = getItemsIndex(selected1);
            if (a == 0) {
              firstMonth[index] = v;
            } else if (a == 1) {
              firstMonth2[index] = v;
            } else if (a == 2) {
              secondMonth[index] = v;
            } else if (a == 3) {
              secondMonth2[index] = v;
            }
          },
          textAlign: TextAlign.center,
          style: TextStyle(
              color: color3,
              fontFamily: 'DroidArabicKufi',
              fontSize: fontx - fontx * 0.1,
              fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          cursorColor: blue,
          readOnly: !isEnable,
          cursorHeight: h * 0.03,
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

  getItemsIndex(String s) {
    int index = items1.indexOf(s);
    return index;
  }

  showErrorDialog(BuildContext context, String errorMessage, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: white,
          child: Container(
            height: h * 0.2,
            width: w * 0.7,
            decoration: boxDecoration(radius: 15),
            child: Column(
              children: [
                Spacer(),
                text(errorMessage,
                    fontSize: f,
                    fontSizesLevel: 1,
                    isBold: true,
                    textColor: color),
                Spacer(),
                TextButton(
                  child: Text(
                    'موافق',
                    style: TextStyle(color: blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Container(
                  height: 10,
                )
              ],
            ),
          ),
        );
      },
    );
  }

}
