// import 'package:flutter/material.dart';
// import 'package:alwastia/bloc/teacher/CloseLectureBloc/bloc.dart';
// import 'package:alwastia/bloc/teacher/CloseLectureBloc/event.dart';
// import 'package:alwastia/bloc/teacher/CloseLectureBloc/state.dart';
// import 'package:alwastia/bloc/teacher/createlectureBloc/bloc.dart';
// import 'package:alwastia/bloc/teacher/createlectureBloc/event.dart';
// import 'package:alwastia/bloc/teacher/createlectureBloc/state.dart';
// import 'package:alwastia/bloc/teacher/getMyClassesBloc/model.dart';
// import 'package:alwastia/bloc/teacher/getMyLecturesBloc/bloc.dart';
// import 'package:alwastia/bloc/teacher/getMyLecturesBloc/event.dart';
// import 'package:alwastia/bloc/teacher/getMyLecturesBloc/state.dart';
// import 'package:alwastia/consts.dart';
// import 'package:alwastia/screens/teacher/class/lecture.dart';
// import 'package:alwastia/widgets/boxdecoration.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class Lectures extends StatefulWidget {
//   late ClassModel element;
//   late BuildContext contx;
//   Lectures({required this.element, required this.contx});

//   @override
//   State<Lectures> createState() =>
//       _LecturesState(element: element, contx: contx);
// }

// class _LecturesState extends State<Lectures>
//     with AutomaticKeepAliveClientMixin {
//   late ClassModel element;
//   late BuildContext contx;

//   _LecturesState({required this.element, required this.contx});
//   bool iswriting = false;
//   List isClicked = [];
//   List<String> isActivated = [];
//   List<Color> isActivatedcolor = [];
//   int itemIndex = 0;
//   int itemindexforClosing = 0;
//   bool closing = false;

//   var lecturenamecontroller = TextEditingController();
//   var lecturedesccontroller = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<GetLecturesBloc>(context)
//         .add(GetMyLectures(classId: element.id));
//   }

//   List<bool> lectureState = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: floatingActionButton(),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       body: BlocListener<GetLecturesBloc, GetLecturesState>(
//         listener: (context, state) => {
//           if (state is MyLectures)
//             {
//               lectureState.clear(),
//               isActivated.clear(),
//               isActivatedcolor.clear(),
//               for (var i = 0; i < state.data.length; i++)
//                 {
//                   lectureState.add(state.data[i].status == '0'),
//                   isActivated
//                       .add(state.data[i].status == '0' ? 'مفعل' : 'غير مفعل'),
//                   isActivatedcolor
//                       .add(state.data[i].status == '0' ? blue : Colors.grey),
//                 }
//             }
//         },
//         child: Container(
//             margin: EdgeInsets.only(left: 16, top: 20, right: 16),
//             child: listview()),
//       ),
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;
//   Widget listview() {
//     return BlocBuilder<GetLecturesBloc, GetLecturesState>(
//         builder: (context, state) {
//       if (state is LoadingState2) {
//         return Container(
//           width: w,
//           height: h * 0.8,
//           child: Center(
//             child: Container(
//               height: h * 0.04,
//               width: h * 0.04,
//               child: CircularProgressIndicator(
//                 color: blue,
//                 strokeWidth: 3,
//               ),
//             ),
//           ),
//         );
//       } else if (state is MyLectures) {
//         if (state.connection) {
//           for (var item in state.data) {
//             isClicked.add(false);
//           }
//           return Container(
//             height: h * 0.8,
//             width: w,
//             child: ListView.builder(
//               itemCount: state.data.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Column(
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (BuildContext context) => Lecture(
//                                   element: state.data[index],
//                                   classinfo: element,
//                                 )));
//                       },
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: h * 0.01),
//                         decoration: BoxDecoration(
//                           color: white,
//                           boxShadow: [
//                             BoxShadow(
//                                 color: Colors.grey.withOpacity(0.2),
//                                 spreadRadius: 1,
//                                 blurRadius: 2,
//                                 offset: Offset(0, -2))
//                           ],
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: w * 0.05,
//                             ),
//                             Container(
//                               child: Center(
//                                 child: InkWell(
//                                   onTap: () {
//                                     setState(() {
//                                       isClicked[index] = !isClicked[index];
//                                     });
//                                   },
//                                   child: Icon(
//                                     isClicked[index]
//                                         ? Icons.keyboard_arrow_up
//                                         : Icons.keyboard_arrow_down,
//                                     size: f * 1.5,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               width: w * 0.03,
//                             ),
//                             Container(
//                               height: h * 0.03,
//                               width: w * 0.1,
//                               child: Center(
//                                 child: Switch(
//                                   onChanged: (v) {
//                                     if (v) {
//                                       if (!closing) {
//                                         itemindexforClosing = index;
//                                         // closing = true;
//                                         BlocProvider.of<CloseLectureBloc>(
//                                                 context)
//                                             .add(ActivateLecture(
//                                                 classId: state.data[index].id));
//                                         setState(() {
//                                           lectureState[index] = true;
//                                           isActivated[index] = 'مفعل';
//                                           isActivatedcolor[index] = blue;
//                                         });
//                                       }
//                                     } else {
//                                       if (!closing) {
//                                         // closing = true;
//                                         itemindexforClosing = index;
//                                         BlocProvider.of<CloseLectureBloc>(
//                                                 context)
//                                             .add(CloseLecture(
//                                                 classId: state.data[index].id));
//                                         setState(() {
//                                           lectureState[index] = false;
//                                           isActivated[index] = 'غير مفعل';
//                                           isActivatedcolor[index] = Colors.grey;
//                                         });
//                                       }
//                                     }
//                                   },
//                                   value: lectureState[index],
//                                   activeColor: blue,
//                                 ),
//                               ),
//                             ),
//                             Container(
//                                 // width: w * 0.1,
//                                 child: Center(child: BlocBuilder<
//                                     CloseLectureBloc, CloseLectureState>(
//                               builder: (context, state) {
//                                 if (state is LoadingState3 &&
//                                     itemindexforClosing == index) {
//                                   return Container(
//                                       height: h * 0.03,
//                                       width: h * 0.03,
//                                       child: CircularProgressIndicator(
//                                         color: blue,
//                                         strokeWidth: 2,
//                                       ));
//                                 } else {
//                                   return Container();
//                                 }
//                               },
//                             ))),
//                             Container(
//                               width: 8,
//                             ),
//                             Container(
//                               // height: h * 0.06,
//                               // width: w,
//                               // padding: EdgeInsets.only(right: h * 0.02),
//                               // margin: EdgeInsets.only(top: h * 0.01),
//                               child: Text(isActivated[index],
//                                   textAlign: TextAlign.right,
//                                   style: TextStyle(
//                                       color: isActivatedcolor[index],
//                                       fontSize: f)),
//                             ),
//                             Spacer(),
//                             Container(
//                               // height: h * 0.06,
//                               // width: w,
//                               padding: EdgeInsets.only(right: h * 0.02),
//                               margin: EdgeInsets.only(top: h * 0.01),
//                               child: Text(state.data[index].name,
//                                   textAlign: TextAlign.right,
//                                   style: TextStyle(color: color3, fontSize: f)),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     !isClicked[index]
//                         ? Container()
//                         : Container(
//                             // height: h * 0.06,
//                             width: w,
//                             decoration: BoxDecoration(
//                               color: white,
//                               boxShadow: [
//                                 BoxShadow(
//                                     color: Colors.grey.withOpacity(0.2),
//                                     spreadRadius: 1,
//                                     blurRadius: 2,
//                                     offset: Offset(0, 2))
//                               ],
//                             ),
//                             padding: EdgeInsets.only(
//                                 right: h * 0.02,
//                                 top: h * 0.02,
//                                 bottom: h * 0.02,
//                                 left: h * 0.03),
//                             // margin: EdgeInsets.only(top: h * 0.01),
//                             child: Text(
//                                 state.data[index].descr == null
//                                     ? ''
//                                     : state.data[index].descr,
//                                 textAlign: TextAlign.right,
//                                 style: TextStyle(color: color3, fontSize: f)),
//                           ),
//                   ],
//                 );
//               },
//             ),
//           );
//         } else {
//           return Container(
//             width: w,
//             height: h * 0.8,
//             child: Column(
//               children: [
//                 Container(
//                   height: h * 0.5,
//                   width: w * 0.8,
//                   decoration: boxDecoration(
//                       imageExsit: true,
//                       bgColor: Colors.transparent,
//                       imageAsset: 'assets/images/noNet2.png',
//                       boxfit: BoxFit.contain),
//                 ),
//                 Container(
//                   height: h * 0.02,
//                 ),
//                 Material(
//                   child: InkWell(
//                       splashColor: white.withOpacity(0.5),
//                       onTap: () {
//                         BlocProvider.of<GetLecturesBloc>(context)
//                             .add(GetMyLectures(classId: element.id));
//                       },
//                       child: buttons('أعد المحاولة', 1, blue)),
//                 )
//               ],
//             ),
//           );
//         }
//       } else {
//         return Container();
//       }
//     });
//   }

//   Widget buildSheets(double height, double width, double fontx) {
//     bool showError = false;
//     String errorString = '';
//     return FractionallySizedBox(
//       heightFactor: iswriting ? 0.8 : 0.6,
//       child: StatefulBuilder(builder: (context, StateSetter setSheetState) {
//         return BlocListener<CreateLectureBloc, CreateLectureState>(
//           listener: (context, state) => {
//             if (state is CreateLectureDone)
//               {
//                 if (state.connection)
//                   {
//                     if (state.res)
//                       {
//                         BlocProvider.of<GetLecturesBloc>(context)
//                             .add(GetMyLectures(classId: element.id)),
//                         setSheetState(() {
//                           lecturenamecontroller.clear();
//                           lecturedesccontroller.clear();
//                           showError = true;
//                           errorString = 'تم إنشاء المحاضرة بنجاح';
//                         })
//                       }
//                     else
//                       {
//                         setSheetState(() {
//                           showError = true;
//                           errorString = 'حصل خطاء ما';
//                         })
//                       }
//                   }
//                 else
//                   {
//                     setSheetState(() {
//                       showError = true;
//                       errorString = 'لا يوجد إتصال بالانترنت';
//                     })
//                   }
//               }
//           },
//           child: Scaffold(
//             body: Container(
//               margin: EdgeInsets.only(top: 5),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(25),
//                       topRight: Radius.circular(25))),
//               height: height * 0.6,
//               child: SingleChildScrollView(
//                 child: Container(
//                   margin: EdgeInsets.only(top: 3),
//                   decoration: BoxDecoration(
//                       color: white,
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(25),
//                           topRight: Radius.circular(25))),
//                   // height: height * 0.41,
//                   child: Column(
//                     children: [
//                       Container(
//                         height: h * 0.05,
//                       ),
//                       buildTextField(h, w, f, lecturenamecontroller,
//                           'عنوان المحاضرة', false),
//                       Container(
//                         height: h * 0.02,
//                       ),
//                       buildTextField2(h, w, f, lecturedesccontroller,
//                           'وصف المحاضرة', false),
//                       Container(
//                         height: h * 0.02,
//                       ),
//                       InkWell(
//                           onTap: () {
//                             print('sss');
//                             if (lecturenamecontroller.text.isEmpty) {
//                               setSheetState(() {
//                                 showError = true;
//                                 errorString = "فضلا ادخل عنوان المحاظرة ";
//                               });
//                             } else
//                               BlocProvider.of<CreateLectureBloc>(context).add(
//                                   CreateLecture(
//                                       name: lecturenamecontroller.text,
//                                       classId: element.id,
//                                       desc: lecturedesccontroller.text));
//                           },
//                           child: buttons('إضافة', 0, green)),
//                       Container(height: h * 0.05),
//                       showError
//                           ? Container(
//                               child: Center(
//                                 child: Text(errorString,
//                                     style: TextStyle(
//                                         color: Colors.red.shade200,
//                                         fontSize: f,
//                                         fontWeight: FontWeight.bold)),
//                               ),
//                             )
//                           : Container(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   FloatingActionButton floatingActionButton() {
//     return FloatingActionButton.extended(
//       onPressed: () {
//         setState(() {
//           iswriting = false;
//         });
//         showModalBottomSheet(
//             backgroundColor: white,
//             isScrollControlled: true,
//             barrierColor: Colors.transparent,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(15),
//                     topRight: Radius.circular(15))),
//             context: context,
//             builder: (context) => buildSheets(
//                   h,
//                   w,
//                   f,
//                 ));
//       },
//       backgroundColor: green,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       foregroundColor: white,
//       icon: Icon(Icons.document_scanner),
//       label: Text("إضافة محاظرة"),
//     );
//   }

//   Directionality buildTextField(double height, double width, double fontx,
//       TextEditingController controller, String hint, bool secureWords) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Container(
//         height: height * 0.07,
//         padding: EdgeInsets.all(0),
//         margin: EdgeInsets.only(
//             left: width * 0.03, right: width * 0.03, top: height * 0.01),
//         decoration: boxDecoration(radius: 5, color: blue.withOpacity(0.2)),
//         child: TextField(
//           controller: controller,
//           maxLines: 1,
//           minLines: 1,
//           onSubmitted: (v) {
//             setState(() {
//               iswriting = false;
//             });
//           },
//           onTap: () {
//             setState(() {
//               iswriting = true;
//             });
//           },
//           textAlign: TextAlign.right,
//           style: TextStyle(
//               color: color3,
//               fontFamily: 'DroidArabicKufi',
//               fontSize: fontx - fontx * 0.1,
//               fontWeight: FontWeight.bold),
//           keyboardType: TextInputType.name,
//           textInputAction: TextInputAction.next,
//           cursorColor: blue,
//           decoration: InputDecoration(
//             fillColor: white,
//             filled: true,
//             hintText: hint,
//             hintStyle: TextStyle(
//                 color: Colors.grey,
//                 fontFamily: 'DroidArabicKufi',
//                 fontSize: fontx,
//                 fontWeight: FontWeight.bold),
//             border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(15)),
//           ),
//           obscureText: secureWords,
//         ),
//       ),
//     );
//   }

//   Directionality buildTextField2(double height, double width, double fontx,
//       TextEditingController controller, String hint, bool secureWords) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Container(
//         height: height * 0.25,
//         padding: EdgeInsets.all(0),
//         margin: EdgeInsets.only(
//             left: width * 0.03, right: width * 0.03, top: height * 0.01),
//         decoration: boxDecoration(radius: 5, color: blue.withOpacity(0.2)),
//         child: TextField(
//           controller: controller,
//           maxLines: null,
//           minLines: 6,
//           textAlign: TextAlign.right,
//           style: TextStyle(
//               color: color3,
//               fontFamily: 'DroidArabicKufi',
//               fontSize: fontx - fontx * 0.1,
//               fontWeight: FontWeight.bold),
//           keyboardType: TextInputType.multiline,
//           textInputAction: TextInputAction.newline,
//           cursorColor: blue,
//           decoration: InputDecoration(
//             fillColor: white,
//             filled: true,
//             hintText: hint,
//             hintStyle: TextStyle(
//                 color: Colors.grey,
//                 fontFamily: 'DroidArabicKufi',
//                 fontSize: fontx,
//                 fontWeight: FontWeight.bold),
//             border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(15)),
//           ),
//           obscureText: secureWords,
//         ),
//       ),
//     );
//   }

//   Material buttons(String txt, int click, Color color) {
//     return Material(
//       child: Container(
//         height: h * 0.07,
//         width: w * 0.7,
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 spreadRadius: 5,
//                 blurRadius: 7,
//                 offset: Offset(0, 3))
//           ],
//           borderRadius: BorderRadius.circular(25),
//           gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 color,
//                 color,
//               ]),
//         ),
//         child: BlocBuilder<CreateLectureBloc, CreateLectureState>(
//             builder: (context, state) {
//           return state is LoadingState
//               ? Center(
//                   child: Container(
//                     height: h * 0.03,
//                     width: h * 0.03,
//                     child: CircularProgressIndicator(
//                       color: white,
//                       strokeWidth: 3,
//                     ),
//                   ),
//                 )
//               : Center(
//                   child: Text(txt,
//                       style: TextStyle(
//                           fontSize: f,
//                           fontWeight: FontWeight.bold,
//                           color: white)),
//                 );
//         }),
//       ),
//     );
//   }

// }
