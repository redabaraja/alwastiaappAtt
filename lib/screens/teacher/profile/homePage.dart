// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:alwastia/bloc/teacher/createclassBloc/bloc.dart';
// import 'package:alwastia/bloc/teacher/createclassBloc/event.dart';
// import 'package:alwastia/bloc/teacher/createclassBloc/state.dart';
// import 'package:alwastia/bloc/teacher/getMyClassesBloc/bloc.dart';
// import 'package:alwastia/bloc/teacher/getMyClassesBloc/event.dart';
// import 'package:alwastia/bloc/teacher/getMyClassesBloc/state.dart';
// import 'package:alwastia/consts.dart';
// import 'package:flutter/material.dart';
// import 'package:alwastia/screens/teacher/class/classroom.dart';
// import 'package:alwastia/widgets/boxdecoration.dart';
// import 'package:alwastia/widgets/text.dart';

// class TeacherHomePage extends StatefulWidget {
//   @override
//   State<TeacherHomePage> createState() => _TeacherHomePageState();
// }

// class _TeacherHomePageState extends State<TeacherHomePage> {
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//   var classnamecontroller = TextEditingController();
//   var classdisccontroller = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<GetClassesBloc>(context).add(GetMyClasses());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         floatingActionButton: floatingActionButton(),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               appBar(h, w, scaffoldKey, context),
//               Container(
//                 height: h * 0.05,
//                 width: w,
//                 child: Center(
//                   child: text('صفوفي',
//                       fontSize: f,
//                       fontSizesLevel: 1,
//                       textColor: color3,
//                       isBold: true),
//                 ),
//               ),
//               Container(height: h*0.07,width: w,color: green),
//               listview(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget listview() {
//     return BlocBuilder<GetClassesBloc, GetClassesState>(
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
//       } else if (state is MyClasses) {
//         if (state.connection) {
//           return Container(
//             width: w,
//             height: h * 0.8,
//             child: ListView.builder(
//               scrollDirection: Axis.vertical,
//               itemCount: state.data.length,
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//                   child: Container(
//                     decoration: boxDecoration(radius: 10, showShadow: true),
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (BuildContext context) => ClassRoom(
//                                   element: state.data[index],
//                                   conxt: context,
//                                 )));
//                       },
//                       child: Card(
//                         semanticContainer: true,
//                         clipBehavior: Clip.antiAliasWithSaveLayer,
//                         child: Row(
//                           children: <Widget>[
//                             Container(
//                               width: w / 3,
//                               height: w / 2.8,
//                               decoration: state.data[index].logo.isEmpty
//                                   ? boxDecoration(
//                                       radius: 8,
//                                       showShadow: true,
//                                       imageExsit: true,
//                                       imagetype: 0,
//                                       boxfit: BoxFit.cover,
//                                       imageAsset: 'assets/images/class.png')
//                                   : boxDecoration(
//                                       radius: 8,
//                                       showShadow: true,
//                                       imageExsit: true,
//                                       imagetype: 1,
//                                       boxfit: BoxFit.cover,
//                                       imageUrl: personImagesPath +
//                                           state.data[index].logo),
//                             ),
//                             Container(
//                               width: w - (w / 3) - 35,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: <Widget>[
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           color: blue,
//                                           borderRadius: new BorderRadius.only(
//                                               bottomRight:
//                                                   const Radius.circular(16.0),
//                                               topRight:
//                                                   const Radius.circular(16.0)),
//                                         ),
//                                         padding:
//                                             EdgeInsets.fromLTRB(8, 2, 8, 2),
//                                         child: text('فتح',
//                                             textColor: white,
//                                             fontSize: f,
//                                             fontSizesLevel: 0),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 8),
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 10.0),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.end,
//                                       children: <Widget>[
//                                         text(state.data[index].name,
//                                             textColor: color3,
//                                             fontSize: f * 1.2,
//                                             textaligntype: 2,
//                                             isBold: true),
//                                         SizedBox(height: 4),
//                                         text(
//                                             "عدد الطلاب: " +
//                                                 state.data[index].stdCount
//                                                     .toString(),
//                                             fontSize: f,
//                                             textaligntype: 2,
//                                             maxLine: 1),
//                                         SizedBox(
//                                           height: 4,
//                                         ),
//                                         text(state.data[index].date,
//                                             fontSize: f,
//                                             textaligntype: 2,
//                                             maxLine: 1),
//                                         SizedBox(height: 4),
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0)),
//                         margin: EdgeInsets.all(0),
//                       ),
//                     ),
//                   ),
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
//                         BlocProvider.of<GetClassesBloc>(context)
//                             .add(GetMyClasses());
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

//   FloatingActionButton floatingActionButton() {
//     return FloatingActionButton.extended(
//       onPressed: () {
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
//       icon: Icon(Icons.class_),
//       label: Text("إضافة صف"),
//     );
//   }

//   Widget buildSheets(double height, double width, double fontx) {
//     bool showError = false;
//     String errorString = '';
//     return FractionallySizedBox(
//       heightFactor: 0.72,
//       child: StatefulBuilder(builder: (context, StateSetter setSheetState) {
//         return BlocListener<CreateClassBloc, CreateClassState>(
//           listener: (context, state) => {
//             if (state is CreateClassDone)
//               {
//                 if (state.connection)
//                   {
//                     if (state.res)
//                       {
//                         BlocProvider.of<GetClassesBloc>(context)
//                             .add(GetMyClasses()),
//                         setSheetState(() {
//                           classdisccontroller.clear();
//                           classnamecontroller.clear();
//                           showError = true;
//                           errorString = 'تم إنشاء الصف بنجاح';
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
//               height: height * 0.72,
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
//                       // addImage(),
//                       Container(
//                         height: h * 0.05,
//                       ),
//                       buildTextField(
//                           h, w, f, classnamecontroller, 'اسم الصف', false),
//                       Container(
//                         height: h * 0.02,
//                       ),
//                       buildTextField2(
//                           h, w, f, classdisccontroller, 'وصف الصف', false),
//                       Container(
//                         height: h * 0.05,
//                       ),
//                       InkWell(
//                           onTap: () {
//                             print('sss');
//                             if (classnamecontroller.text.isEmpty) {
//                               setSheetState(() {
//                                 showError = true;
//                                 errorString = "فضلا ادخل اسم الصف";
//                               });
//                             } else if (classdisccontroller.text.isEmpty) {
//                               setSheetState(() {
//                                 showError = true;
//                                 errorString = "فضلا ادخل وصف للصف";
//                               });
//                             } else
//                               BlocProvider.of<CreateClassBloc>(context).add(
//                                   CreateClass(
//                                       name: classnamecontroller.text,
//                                       descr: classdisccontroller.text));
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

//   Container addImage() {
//     return Container(
//       width: w,
//       child: Center(
//         child: Container(
//           height: h * 0.2,
//           width: w * 0.6,
//           decoration: boxDecoration(showShadow: true, color: blue, radius: 10),
//           child: Center(
//             child: text('صورة',
//                 fontSize: f, fontSizesLevel: 1, isBold: true, textColor: green),
//           ),
//         ),
//       ),
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
//         child: BlocBuilder<CreateClassBloc, CreateClassState>(
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
