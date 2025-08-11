// import 'package:alwastia/bloc/teacher/getMyClassesBloc/model.dart';
// import 'package:alwastia/consts.dart';
// import 'package:flutter/material.dart';
// import 'package:alwastia/screens/teacher/class/addMarks.dart';
// import 'package:alwastia/screens/teacher/class/lectures2.dart';
// import 'package:alwastia/screens/teacher/class/noti.dart';
// import 'package:alwastia/screens/teacher/class/students.dart';
// import 'package:alwastia/widgets/text.dart';

// class StudentsMenu extends StatefulWidget {
//   late ClassModel element;
//   StudentsMenu({required this.element});
//   @override
//   State<StudentsMenu> createState() => _StudentsMenuState(element: element);
// }

// class _StudentsMenuState extends State<StudentsMenu> {
//   late ClassModel element;
//   _StudentsMenuState({required this.element});
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           child: Column(
//             children: <Widget>[
//               InkWell(
//                   onTap: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: (BuildContext context) =>
//                             ClassStudents(element: element)));
//                   },
//                   child: menuItem('عرض الطلاب')),
//               line(),
//               InkWell(
//                   onTap: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: (BuildContext context) =>
//                             Noti2(element: element)));
//                   },
//                   child: menuItem('الإشعارات')),
//               line(),
//               InkWell(
//                   onTap: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: (BuildContext context) =>
//                             ClassStudentsMarks(element: element)));
//                   },
//                   child: menuItem('إضافة درجات')),
//               line(),
//               InkWell(
//                   onTap: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: (BuildContext context) =>
//                             Lectures2(element: element)));
//                   },
//                   child: menuItem('تحضير الطلاب')),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Container menuItem(String name) {
//     return Container(
//       height: h * 0.05,
//       width: w,
//       child: Row(
//         children: <Widget>[
//           Container(
//             width: w * 0.15,
//           ),
//           Icon(
//             Icons.arrow_back_ios,
//             size: f,
//             color: blue,
//           ),
//           Spacer(),
//           Container(
//             height: h * 0.07,
//             child: Center(
//               child:
//                   text(name, fontSize: f, fontSizesLevel: 0, textColor: blue),
//             ),
//           ),
//           Container(
//             width: w * 0.1,
//           ),
//         ],
//       ),
//     );
//   }

//   Container line() {
//     return Container(
//       height: 1,
//       color: blue.withOpacity(0.2),
//     );
//   }
// }
