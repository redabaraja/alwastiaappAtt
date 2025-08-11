// import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';
// import 'package:alwastia/bloc/student/getStdMarks/bloc.dart';
// import 'package:alwastia/bloc/student/getStdMarks/event.dart';
// import 'package:alwastia/bloc/student/getStdMarks/state.dart';
// import 'package:alwastia/bloc/student/getStdMarks/model.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:alwastia/consts.dart';
// import 'package:flutter/material.dart';
// import 'package:alwastia/widgets/boxdecoration.dart';
// import 'package:alwastia/widgets/text.dart';

// class StdMarks extends StatefulWidget {
//   late ClassModel2 element;
//   StdMarks({required this.element});
//   @override
//   State<StdMarks> createState() => _StdMarksState(element: element);
// }

// class _StdMarksState extends State<StdMarks> {
//   late ClassModel2 element;
//   _StdMarksState({required this.element});
//   var titleController = TextEditingController();
//   var markController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<GetStdMarksBloc>(context)
//         .add(GetMarks(classId: element.id));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: Column(
//         children: [
//           Container(
//             height: h * 0.1,
//             width: w,
//             child: Center(
//               child: Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: text('النتائج',
//                       fontSize: f,
//                       fontSizesLevel: 1,
//                       textColor: color3,
//                       isBold: true)),
//             ),
//           ),
//           BlocBuilder<GetStdMarksBloc, GetStdMarksState>(
//               builder: (context, state) {
//             if (state is LoadingState) {
//               return Container(
//                 height: h * 0.8,
//                 width: w * 0.9,
//                 child: Center(
//                   child: Container(
//                     width: h * 0.04,
//                     height: h * 0.04,
//                     child: CircularProgressIndicator(
//                       color: blue,
//                       strokeWidth: 2,
//                     ),
//                   ),
//                 ),
//               );
//             } else if (state is GetMarksDone) {
//               if (state.connection) {
//                 return Container(
//                     height: h * 0.8,
//                     width: w,
//                     child: Column(
//                       children: [
//                         Spacer(),
//                         Container(
//                           height: h * 0.24,
//                           width: w * 0.8,
//                           decoration: boxDecoration(radius: 5, color: blue),
//                           child: Column(
//                             children: [
//                               Container(
//                                 height: h * 0.07,
//                                 width: w * 0.8,
//                                 decoration: BoxDecoration(
//                                     color: blue,
//                                     borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(5),
//                                         topRight: Radius.circular(5))),
//                                 child: Center(
//                                   child: text('الشهر الاول',
//                                       fontSize: f,
//                                       fontSizesLevel: 1,
//                                       isBold: true,
//                                       textColor: white),
//                                 ),
//                               ),
//                               Container(height: 1,),
//                               Container(
//                                 height: h * 0.07,
//                                 width: w * 0.8,
//                                 color: blue,
//                                 // decoration: BoxDecoration(
//                                 //     color: blue,
//                                 //     borderRadius: BorderRadius.only(
//                                 //         topLeft: Radius.circular(5),
//                                 //         topRight: Radius.circular(5))),
//                                 child: Row(
//                                   children: [
//                                     Spacer(),
//                                     text('عملي',
//                                         fontSize: f,
//                                         fontSizesLevel: 0,
//                                         isBold: true,
//                                         textColor: white),
//                                     Spacer(),
//                                     text('نظري',
//                                         fontSize: f,
//                                         fontSizesLevel: 0,
//                                         isBold: true,
//                                         textColor: white),
//                                     Spacer(),
//                                   ],
//                                 ),
//                               ),
//                               Spacer(),
//                               Container(
//                                 height: h * 0.07,
//                                 width: w * 0.8,
//                                 // color: blue,
//                                 decoration: BoxDecoration(
//                                     color: white,
//                                     borderRadius: BorderRadius.only(
//                                         bottomLeft: Radius.circular(5),
//                                         bottomRight: Radius.circular(5))),
//                                 child: Row(
//                                   children: [
//                                     Spacer(),
//                                     text(
//                                         state.data.firstMonthPractical
//                                             .toString(),
//                                         fontSize: f,
//                                         fontSizesLevel: 0,
//                                         isBold: true,
//                                         textColor: blue),
//                                     Spacer(),
//                                     Container(
//                                       height: h * 0.07,
//                                       width: 1,
//                                       color: Colors.black.withOpacity(0.5),
//                                     ),
//                                     Spacer(),
//                                     text(state.data.firstMonthTheory.toString(),
//                                         fontSize: f,
//                                         fontSizesLevel: 0,
//                                         isBold: true,
//                                         textColor: blue),
//                                     Spacer(),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Spacer(),
//                         Container(
//                           height: h * 0.24,
//                           width: w * 0.8,
//                           decoration: boxDecoration(radius: 5, color: blue),
//                           child: Column(
//                             children: [
//                               Container(
//                                 height: h * 0.07,
//                                 width: w * 0.8,
//                                 decoration: BoxDecoration(
//                                     color: blue,
//                                     borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(5),
//                                         topRight: Radius.circular(5))),
//                                 child: Center(
//                                   child: text('الشهر الثاني',
//                                       fontSize: f,
//                                       fontSizesLevel: 1,
//                                       isBold: true,
//                                       textColor: white),
//                                 ),
//                               ),
//                               Container(height: 1,),
//                               Container(
//                                 height: h * 0.07,
//                                 width: w * 0.8,
//                                 color: blue,
//                                 // decoration: BoxDecoration(
//                                 //     color: blue,
//                                 //     borderRadius: BorderRadius.only(
//                                 //         topLeft: Radius.circular(5),
//                                 //         topRight: Radius.circular(5))),
//                                 child: Row(
//                                   children: [
//                                     Spacer(),
//                                     text('عملي',
//                                         fontSize: f,
//                                         fontSizesLevel: 0,
//                                         isBold: true,
//                                         textColor: white),
//                                     Spacer(),
//                                     text('نظري',
//                                         fontSize: f,
//                                         fontSizesLevel: 0,
//                                         isBold: true,
//                                         textColor: white),
//                                     Spacer(),
//                                   ],
//                                 ),
//                               ),
//                               Spacer(),
//                               Container(
//                                 height: h * 0.07,
//                                 width: w * 0.8,
//                                 // color: blue,
//                                 decoration: BoxDecoration(
//                                     color: white,
//                                     borderRadius: BorderRadius.only(
//                                         bottomLeft: Radius.circular(5),
//                                         bottomRight: Radius.circular(5))),
//                                 child: Row(
//                                   children: [
//                                     Spacer(),
//                                     text(
//                                         state.data.secondMonthPractical
//                                             .toString(),
//                                         fontSize: f,
//                                         fontSizesLevel: 0,
//                                         isBold: true,
//                                         textColor: blue),
//                                     Spacer(),
//                                     Container(
//                                       height: h * 0.07,
//                                       width: 1,
//                                       color: Colors.black.withOpacity(0.5),
//                                     ),
//                                     Spacer(),
//                                     text(state.data.secondMonthTheory.toString(),
//                                         fontSize: f,
//                                         fontSizesLevel: 0,
//                                         isBold: true,
//                                         textColor: blue),
//                                     Spacer(),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Spacer(),
//                         Container(
//                           height: h * 0.24,
//                           width: w * 0.8,
//                           decoration: boxDecoration(radius: 5, color: blue),
//                           child: Column(
//                             children: [
//                               Container(
//                                 height: h * 0.07,
//                                 width: w * 0.8,
//                                 decoration: BoxDecoration(
//                                     color: blue,
//                                     borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(5),
//                                         topRight: Radius.circular(5))),
//                                 child: Center(
//                                   child: text('الفصلي',
//                                       fontSize: f,
//                                       fontSizesLevel: 1,
//                                       isBold: true,
//                                       textColor: white),
//                                 ),
//                               ),
//                               Container(height: 1,),
//                               Container(
//                                 height: h * 0.07,
//                                 width: w * 0.8,
//                                 color: blue,
//                                 // decoration: BoxDecoration(
//                                 //     color: blue,
//                                 //     borderRadius: BorderRadius.only(
//                                 //         topLeft: Radius.circular(5),
//                                 //         topRight: Radius.circular(5))),
//                                 child: Row(
//                                   children: [
//                                     Spacer(),
//                                     text('عملي',
//                                         fontSize: f,
//                                         fontSizesLevel: 0,
//                                         isBold: true,
//                                         textColor: white),
//                                     Spacer(),
//                                     text('نظري',
//                                         fontSize: f,
//                                         fontSizesLevel: 0,
//                                         isBold: true,
//                                         textColor: white),
//                                     Spacer(),
//                                   ],
//                                 ),
//                               ),
//                               Spacer(),
//                               Container(
//                                 height: h * 0.07,
//                                 width: w * 0.8,
//                                 // color: blue,
//                                 decoration: BoxDecoration(
//                                     color: white,
//                                     borderRadius: BorderRadius.only(
//                                         bottomLeft: Radius.circular(5),
//                                         bottomRight: Radius.circular(5))),
//                                 child: Row(
//                                   children: [
//                                     Spacer(),
//                                     text(
//                                         state.data.degreeOfFinalPractice
//                                             .toString(),
//                                         fontSize: f,
//                                         fontSizesLevel: 0,
//                                         isBold: true,
//                                         textColor: blue),
//                                     Spacer(),
//                                     Container(
//                                       height: h * 0.07,
//                                       width: 1,
//                                       color: Colors.black.withOpacity(0.5),
//                                     ),
//                                     Spacer(),
//                                     text(state.data.degreeOfFinalTheory.toString(),
//                                         fontSize: f,
//                                         fontSizesLevel: 0,
//                                         isBold: true,
//                                         textColor: blue),
//                                     Spacer(),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                        Spacer()
                     
//                       ],
//                     ));
//               }
//                else {
//                 return Container(
//                   height: h * 0.8,
//                   width: w * 0.9,
//                   child: Center(
//                     child: InkWell(
//                       onTap: () {
//                         BlocProvider.of<GetStdMarksBloc>(context)
//                             .add(GetMarks(classId: element.id));
//                       },
//                       child: Container(
//                         height: h * 0.5,
//                         width: w * 0.7,
//                         decoration: boxDecoration(
//                             imageExsit: true,
//                             imageAsset: "assets/images/noNet2.png"),
//                       ),
//                     ),
//                   ),
//                 );
//               }
//             } else {
//               return Container();
//             }
//           })
//         ],
//       ),
//     ));
//   }

// }
