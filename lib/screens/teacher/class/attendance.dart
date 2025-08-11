import 'package:alwastia/bloc/teacher/getAttendances/bloc.dart';
import 'package:alwastia/bloc/teacher/getAttendances/event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/teacher/getMyClassesBloc/model.dart';
import 'package:alwastia/bloc/teacher/getMyLecturesBloc/model.dart';
import 'package:alwastia/bloc/teacher/getStudentsAttendance.dart/bloc.dart';
import 'package:alwastia/bloc/teacher/getStudentsAttendance.dart/event.dart';
import 'package:alwastia/bloc/teacher/getStudentsAttendance.dart/state.dart';
import 'package:alwastia/bloc/teacher/saveAttendanceBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/saveAttendanceBloc/event.dart';
import 'package:alwastia/bloc/teacher/saveAttendanceBloc/state.dart';

import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';

class Attendance extends StatefulWidget {
  late ClassModel element;
  late String attendanceId;
  late String hours;
  late bool isnew;
  Attendance(
      {required this.element,
      required this.attendanceId,
      required this.isnew,
      required this.hours});

  @override
  State<Attendance> createState() => _AttendanceState(
      element: element, attendanceId: attendanceId, isnew: isnew, hours: hours);
}

class _AttendanceState extends State<Attendance> {
  late ClassModel element;
  late String attendanceId;
  late String hours;
  late bool isnew;
  _AttendanceState(
      {required this.element,
      required this.attendanceId,
      required this.isnew,
      required this.hours});
  @override
  void initState() {
    super.initState();
    if (!isnew) {
      print('\n\n\n $attendanceId \n\n\n');
      selected1 = attendanceId.split('&')[1].split('=')[1];
      hintdate = attendanceId.split('&')[0];
      dateSelected = true;
      hourController.text = hours;
    }
    BlocProvider.of<GetClassStudentsAttendanceBloc>(context).add(
        GetMyStudentsAttendance(
            classId: element.id, isnew: isnew, lectureId: attendanceId));
  }

  List<String> items1 = [
    'المحاضرةالأولى',
    'المحاضرةالثانية',
    'المحاضرةالثالثة',
    'المحاضرةالرابعة',
    'المحاضرة الخامسة',
    'المحاضرةالسادسة',
  ];
  String selected1 = 'المحاضرةالأولى';
  DateTime date = DateTime.now();
  String hintdate = 'التاريخ';
  bool dateSelected = false;

  int itemindexforClosing = 0;
  List<bool> stdState = [];
  List<bool> checksState = [];
  List<int> ids = [];
  List<int> attendance = [];
  List<String> names = [];
  List<String> pids = [];
  List<String> snames = [];
  List<String> spids = [];
  List<bool> scheck = [];
  List<int> sindexs = [];
  bool checkAll = false;
  bool showerror = false;
  String errorString = '';
  TextEditingController hourController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: floatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: BlocListener<SaveAttendanceBloc, SaveAttendanceState>(
          listener: (context, state) => {
            if (state is SaveDone)
              {
                if (state.res)
                  {
                    BlocProvider.of<GetAttendanceDatesBloc>(context)
                        .add(GetMyAttendanceDates(classId: element.id)),
                    showErrorDialog(context, 'تم الحفظ', blue)
                  }
                else
                  {
                    showErrorDialog(
                        context, 'حصل خطا في الحفظ', Colors.red.shade300)
                  }
              }
          },
          child: BlocListener<GetClassStudentsAttendanceBloc,
              GetClassStudentsAttendanceState>(
            listener: (context, state) => {
              if (state is MyStudentsAttendance)
                {
                  for (var i = 0; i < state.data.length; i++)
                    {
                      stdState.add(state.data[i].status == 0),
                      checksState.add(state.data[i].isAttended),
                      ids.add(state.data[i].id),
                      attendance.add(state.data[i].isAttended ? 1 : 0),
                      names.add(state.data[i].name),
                      pids.add(state.data[i].userID)
                    },
                  setState(() {})
                }
              else if (state is MyNewStudentsAttendance)
                {
                  for (var i = 0; i < state.data.length; i++)
                    {
                      stdState.add(state.data[i].status == 0),
                      checksState.add(true),
                      ids.add(state.data[i].id),
                      attendance.add(1),
                      names.add(state.data[i].name),
                      pids.add(state.data[i].userID)
                    },
                  setState(() {})
                }
              else if (state is SearchDone)
                {
                  print('we are here in searchDone state'),
                  snames = state.names,
                  spids = state.pids,
                  scheck = state.checkStatus,
                  sindexs = state.indexs,
                  setState(() {})
                }
            },
            child: BlocBuilder<GetClassStudentsAttendanceBloc,
                GetClassStudentsAttendanceState>(builder: (context, state) {
              String stdCount = '';
              state is MyStudentsAttendance
                  ? stdCount = state.data.length.toString()
                  : state is MyNewStudentsAttendance
                      ? stdCount = state.data.length.toString()
                      : '';

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: h * 0.1,
                      width: w,
                      child: Row(
                        children: [
                          Spacer(),
                          Checkbox(
                              value: checkAll,
                              checkColor: white,
                              activeColor: blue.withOpacity(0.7),
                              onChanged: (v) {
                                setState(() {
                                  checkAll = !checkAll;
                                  if (checkAll) {
                                    for (var i = 0;
                                        i < checksState.length;
                                        i++) {
                                      checksState[i] = true;
                                      attendance[i] = 1;
                                    }
                                  } else {
                                    for (var i = 0;
                                        i < checksState.length;
                                        i++) {
                                      checksState[i] = false;
                                      attendance[i] = 0;
                                    }
                                  }
                                });
                              }),
                          Container(
                            width: 3,
                          ),
                          text("الكل",
                              fontSize: f,
                              fontSizesLevel: 1,
                              textColor: color3,
                              isBold: true),
                          Spacer(),
                          Container(
                            child: Center(
                              child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: text(('عدد الطلاب:' + " " + stdCount),
                                      fontSize: f,
                                      fontSizesLevel: 1,
                                      textColor: color3,
                                      isBold: true)),
                            ),
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_forward,
                                color: blue,
                              )),
                          Container(
                            width: 5,
                          )
                        ],
                      ),
                    ),
                    isnew
                        ? selector('المحاضرة الاولى', selected1, items1, 1)
                        : Container(
                            height: h * 0.07,
                            width: w * 0.93,
                            padding: EdgeInsets.only(right: 5),
                            alignment: Alignment.centerRight,
                            decoration: boxDecoration(
                                radius: 10, color: blue, bgColor: white),
                            child: text(selected1,
                                fontSize: f,
                                fontSizesLevel: 0,
                                isBold: true,
                                textColor: color3.withOpacity(0.8)),
                          ),
                    Row(
                      children: [
                        Container(
                          width: w * 0.5,
                          child: buildTextField(
                              h, w, f, hourController, 'عدد الساعات', false),
                        ),
                        InkWell(
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: DateTime(2017),
                                lastDate: DateTime(2050));
                            if (newDate == null) {
                              return;
                            } else {
                              dateSelected = true;
                              setState(() {
                                date = newDate;
                                hintdate =
                                    '${date.year}-${date.month}-${date.day}';
                              });
                            }
                          },
                          child: Container(
                            height: h * 0.07,
                            width: w * 0.45,
                            padding: EdgeInsets.all(0),
                            margin: EdgeInsets.only(
                                left: w * 0.01, right: w * 0.01, top: h * 0.01),
                            decoration: boxDecoration(radius: 15, color: blue),
                            child: Center(
                              child: text(hintdate,
                                  fontSize: f,
                                  fontSizesLevel: 0,
                                  isBold: true,
                                  textColor: Colors.grey.shade500),
                            ),
                          ),
                        ),
                      ],
                    ),
                    buildTextFieldWithIcon(
                        h, w, f, searchController, 'ابحث', false),
                    state is LoadingState
                        ? Container(
                            width: w,
                            height: h * 0.57,
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
                        : state is SearchDone
                            ? Container(
                                // height: h * 0.57,
                                width: w,
                                child: ListView.builder(
                                  itemCount: snames.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            print('it is checked');
                                            setState(() {
                                              scheck[index] = !scheck[index];
                                              if (scheck[index] == false) {
                                                checkAll = false;
                                              }
                                              checksState[sindexs[index]] =
                                                  scheck[index];
                                              attendance[sindexs[index]] =
                                                  scheck[index] ? 1 : 0;
                                            });
                                            print('\n $attendance\n');
                                          },
                                          child: Container(
                                            height: h * 0.12,
                                            width: w,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: w * 0.06,
                                                ),
                                                Container(
                                                  height: h * 0.03,
                                                  width: w * 0.1,
                                                  child: Center(
                                                      child: Checkbox(
                                                          value: scheck[index],
                                                          checkColor: white,
                                                          activeColor: blue
                                                              .withOpacity(0.7),
                                                          onChanged: (v) {
                                                            print(
                                                                'it is checked');
                                                            setState(() {
                                                              scheck[index] =
                                                                  !scheck[
                                                                      index];
                                                              if (scheck[
                                                                      index] ==
                                                                  false) {
                                                                checkAll =
                                                                    false;
                                                              }
                                                              checksState[sindexs[
                                                                      index]] =
                                                                  scheck[index];
                                                              attendance[sindexs[
                                                                      index]] =
                                                                  scheck[index]
                                                                      ? 1
                                                                      : 0;
                                                            });
                                                            print(
                                                                '\n $attendance\n');
                                                          })),
                                                ),
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
                                                              snames[index],
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
                                                          child: text(
                                                              "رقم القيد : ${spids[index]}",
                                                              fontSize: f,
                                                              fontSizesLevel: 0,
                                                              textColor:
                                                                  color3),
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
                                                      child: null == null
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
                                                                  imageUrl: ''
                                                                  // personImagesPath2 +
                                                                  //     state
                                                                  //         .data[
                                                                  //             index]
                                                                  //         .logo
                                                                  ),
                                                            )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: color3.withOpacity(0.1),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              )
                            : state is MyStudentsAttendance
                                ? Container(
                                    // height: h * 0.57,
                                    width: w,
                                    child: ListView.builder(
                                      itemCount: state.data.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                print('it is checked');
                                                setState(() {
                                                  checksState[index] =
                                                      !checksState[index];
                                                  if (checksState[index] ==
                                                      false) {
                                                    checkAll = false;
                                                  }
                                                  attendance[index] =
                                                      checksState[index]
                                                          ? 1
                                                          : 0;
                                                });
                                                print('\n $attendance\n');
                                              },
                                              child: Container(
                                                height: h * 0.12,
                                                width: w,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: w * 0.06,
                                                    ),
                                                    Container(
                                                      height: h * 0.03,
                                                      width: w * 0.1,
                                                      child: Center(
                                                          child: Checkbox(
                                                              value:
                                                                  checksState[
                                                                      index],
                                                              checkColor: white,
                                                              activeColor: blue
                                                                  .withOpacity(
                                                                      0.7),
                                                              onChanged: (v) {
                                                                print(
                                                                    'it is checked');
                                                                setState(() {
                                                                  checksState[
                                                                          index] =
                                                                      !checksState[
                                                                          index];
                                                                  attendance[
                                                                          index] =
                                                                      checksState[
                                                                              index]
                                                                          ? 1
                                                                          : 0;
                                                                });
                                                                print(
                                                                    '\n $attendance\n');
                                                              })),
                                                    ),
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
                                                                  state
                                                                      .data[
                                                                          index]
                                                                      .name,
                                                                  fontSize: f,
                                                                  fontSizesLevel:
                                                                      1,
                                                                  isBold: true,
                                                                  textaligntype:
                                                                      2,
                                                                  textColor:
                                                                      color3),
                                                            ),
                                                            Spacer(),
                                                            Container(
                                                              width: w * 0.6,
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: text(
                                                                  "رقم القيد : ${state.data[index].userID}",
                                                                  fontSize: f,
                                                                  fontSizesLevel:
                                                                      0,
                                                                  textColor:
                                                                      color3),
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
                                                          child: state
                                                                      .data[
                                                                          index]
                                                                      .logo ==
                                                                  ''
                                                              ? Container(
                                                                  height:
                                                                      h * 0.08,
                                                                  width:
                                                                      h * 0.08,
                                                                  decoration: boxDecoration(
                                                                      radius:
                                                                          100,
                                                                      color:
                                                                          blue,
                                                                      imageExsit:
                                                                          true,
                                                                      boxfit: BoxFit
                                                                          .cover,
                                                                      imageAsset:
                                                                          'assets/images/person.png'),
                                                                )
                                                              : Container(
                                                                  height:
                                                                      h * 0.08,
                                                                  width:
                                                                      h * 0.08,
                                                                  decoration: boxDecoration(
                                                                      radius:
                                                                          100,
                                                                      color:
                                                                          blue,
                                                                      boxfit: BoxFit
                                                                          .cover,
                                                                      imageExsit:
                                                                          true,
                                                                      imagetype:
                                                                          1,
                                                                      imageUrl: baseUrl3 +
                                                                          '/' +
                                                                          state
                                                                              .data[index]
                                                                              .logo),
                                                                )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 1,
                                              color: color3.withOpacity(0.1),
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                : state is MyNewStudentsAttendance
                                    ? Container(
                                        height: h * 0.65,
                                        width: w,
                                        child: ListView.builder(
                                          itemCount: state.data.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    print('it is checked');
                                                    setState(() {
                                                      checksState[index] =
                                                          !checksState[index];
                                                      if (checksState[index] ==
                                                          false) {
                                                        checkAll = false;
                                                      }
                                                      attendance[index] =
                                                          checksState[index]
                                                              ? 1
                                                              : 0;
                                                    });
                                                    print('\n $attendance\n');
                                                  },
                                                  child: Container(
                                                    height: h * 0.12,
                                                    width: w,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: w * 0.06,
                                                        ),
                                                        Container(
                                                          height: h * 0.03,
                                                          width: w * 0.1,
                                                          child: Center(
                                                              child: Checkbox(
                                                                  value:
                                                                      checksState[
                                                                          index],
                                                                  checkColor:
                                                                      white,
                                                                  activeColor: blue
                                                                      .withOpacity(
                                                                          0.7),
                                                                  onChanged:
                                                                      (v) {
                                                                    setState(
                                                                        () {
                                                                      checksState[
                                                                              index] =
                                                                          !checksState[
                                                                              index];
                                                                      if (checksState[
                                                                              index] ==
                                                                          false) {
                                                                        checkAll =
                                                                            false;
                                                                      }
                                                                      attendance[
                                                                          index] = checksState[
                                                                              index]
                                                                          ? 1
                                                                          : 0;
                                                                    });
                                                                  })),
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          height: h * 0.12,
                                                          width: w * 0.6,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Directionality(
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            child: Column(
                                                              children: [
                                                                Spacer(),
                                                                Container(
                                                                  width:
                                                                      w * 0.6,
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child: text(
                                                                      state
                                                                          .data[
                                                                              index]
                                                                          .name,
                                                                      fontSize:
                                                                          f,
                                                                      fontSizesLevel:
                                                                          1,
                                                                      isBold:
                                                                          true,
                                                                      textaligntype:
                                                                          2,
                                                                      textColor:
                                                                          color3),
                                                                ),
                                                                Spacer(),
                                                                Container(
                                                                  width:
                                                                      w * 0.6,
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child: text(
                                                                      "رقم القيد : ${state.data[index].userID}",
                                                                      fontSize:
                                                                          f,
                                                                      fontSizesLevel:
                                                                          0,
                                                                      textColor:
                                                                          color3),
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
                                                              child: state
                                                                          .data[
                                                                              index]
                                                                          .logo ==
                                                                      ''
                                                                  ? Container(
                                                                      height: h *
                                                                          0.08,
                                                                      width: h *
                                                                          0.08,
                                                                      decoration: boxDecoration(
                                                                          radius:
                                                                              100,
                                                                          color:
                                                                              blue,
                                                                          imageExsit:
                                                                              true,
                                                                          boxfit: BoxFit
                                                                              .cover,
                                                                          imageAsset:
                                                                              'assets/images/person.png'),
                                                                    )
                                                                  : Container(
                                                                      height: h *
                                                                          0.08,
                                                                      width: h *
                                                                          0.08,
                                                                      decoration: boxDecoration(
                                                                          radius:
                                                                              100,
                                                                          color:
                                                                              blue,
                                                                          boxfit: BoxFit
                                                                              .cover,
                                                                          imageExsit:
                                                                              true,
                                                                          imagetype:
                                                                              1,
                                                                          imageUrl: baseUrl3 +
                                                                              '/' +
                                                                              state.data[index].logo),
                                                                    )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 1,
                                                  color:
                                                      color3.withOpacity(0.1),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      )
                                    : Container()
                  ],
                ),
              );
            }),
          ),
        ),
      ),
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
        decoration: boxDecoration(radius: 15, color: blue),
        child: TextField(
          controller: controller,
          maxLines: 1,
          minLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: color3,
              fontFamily: 'DroidArabicKufi',
              fontSize: fontx - fontx * 0.1,
              fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
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

  Directionality buildTextFieldWithIcon(
      double height,
      double width,
      double fontx,
      TextEditingController controller,
      String hint,
      bool secureWords) {
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
          textAlign: TextAlign.center,
          style: TextStyle(
              color: color3,
              fontFamily: 'DroidArabicKufi',
              fontSize: fontx - fontx * 0.1,
              fontWeight: FontWeight.bold),
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.done,
          cursorColor: blue,
          onChanged: (v) {
            print(v);
            BlocProvider.of<GetClassStudentsAttendanceBloc>(context).add(Search(
                token: v, names: names, pids: pids, checkStatus: checksState));
          },
          decoration: InputDecoration(
            fillColor: white,
            prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: blue,
                )),
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

  Material buttons(String txt, int click, Color color, int n) {
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
        child: BlocBuilder<SaveAttendanceBloc, SaveAttendanceState>(
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

  Container selector(String txt, String ctxt, List<String> data, int n) {
    return Container(
      height: h * 0.07,
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: w * 0.01),
      decoration: boxDecoration(radius: 10, color: blue),
      child: Column(
        children: [
          // Container(
          //   // width: w * 0.45,
          //   padding: EdgeInsets.only(top: h * 0.01),
          //   child: Align(
          //     alignment: Alignment.centerRight,
          //     child: text(txt,
          //         fontSize: f,
          //         fontSizesLevel: 0,
          //         isBold: true,
          //         textColor: darkmode ? white.withOpacity(0.8) : black),
          //   ),
          // ),

          Container(
            // height: h * 0.04,
            // width: w * 0.45,
            padding: EdgeInsets.only(right: 8, left: 4),
            decoration:
                boxDecoration(radius: 20, bgColor: white.withOpacity(0.3)),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    isExpanded: true,
                    value: ctxt,
                    dropdownColor: white,
                    items: data.map(bulidMenuItem).toList(),
                    onChanged: (value) {
                      setState(() {
                        selected1 = value!;
                      });
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> bulidMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      );

  bool validation() {
    bool res = true;
    if (isnew && hourController.text.isEmpty) {
      res = false;
      showErrorDialog(context, 'فضلا ادخل عدد الساعات', Colors.red.shade300);
    } else if (!dateSelected) {
      res = false;
      showErrorDialog(
          context, 'فضلا ادخل تاريخ المحاضرة ', Colors.red.shade300);
    }
    return res;
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        if (validation()) {
          if (isnew) {
            String lid = 'atDate=$hintdate&Lecture=$selected1';
            BlocProvider.of<SaveAttendanceBloc>(context).add(SaveAttendance(
                lectureId: lid,
                ids: ids,
                hours: hourController.text,
                classid: element.id,
                attendance: attendance));
          } else {
            // print(attendanceId);
            // print('between yehhhhhhh');
            // print(hourController.text);
            String lid = 'atDate=$hintdate&Lecture=$selected1';
            BlocProvider.of<SaveAttendanceBloc>(context).add(SaveAttendance(
                lectureId: lid,
                ids: ids,
                hours: hourController.text,
                classid: element.id,
                attendance: attendance));
          }
        }
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (BuildContext context) => Attendance(
        //           element: element,
        //           attendanceId: '',
        //           isnew: true,
        //           hours: '',
        //         )));
      },
      backgroundColor: blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      foregroundColor: white,
      icon: Icon(Icons.file_present),
      label: BlocBuilder<SaveAttendanceBloc, SaveAttendanceState>(
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
                child: Text('حفظ',
                    style: TextStyle(
                        fontSize: f,
                        fontWeight: FontWeight.bold,
                        color: white)),
              );
      }),
    );
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
