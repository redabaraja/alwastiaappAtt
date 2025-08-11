// // import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:alwastia/bloc/teacher/getMyClassesBloc/model.dart';
// import 'package:alwastia/bloc/teacher/getMyLecturesBloc/model.dart';
// import 'package:alwastia/consts.dart';
// import 'package:alwastia/screens/teacher/class/aboutLecture.dart';
// import 'package:alwastia/screens/teacher/class/files.dart';
// import 'package:alwastia/screens/teacher/class/qutions.dart';
// import 'package:alwastia/widgets/boxdecoration.dart';
// import 'package:alwastia/widgets/text.dart';

// class Lecture extends StatefulWidget {
//   late LectureModel element;
//   late ClassModel classinfo;
//   Lecture({required this.element, required this.classinfo});
//   @override
//   LectureState createState() =>
//       LectureState(element: element, classinfo: classinfo);
// }

// class LectureState extends State<Lecture> {
//   late LectureModel element;
//   late ClassModel classinfo;
//   LectureState({required this.element, required this.classinfo});
//   @override
//   void initState() {
//     super.initState();
//   }

//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: DefaultTabController(
//         length: 3,
//         initialIndex: 2,
//         child: NestedScrollView(
//           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//             return <Widget>[
//               SliverAppBar(
//                 expandedHeight: MediaQuery.of(context).size.height * 0.3 + 60,
//                 floating: false,
//                 pinned: true,
//                 titleSpacing: 0,
//                 backgroundColor: innerBoxIsScrolled ? websiteBlue : websiteBlue,
//                 actionsIconTheme: IconThemeData(opacity: 0.0),
//                 title: Container(
//                   height: 60,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Spacer(),
//                       Text(
//                         'منصة التعليم الإلكتروني',
//                         style: TextStyle(color: white),
//                       ),
//                       Spacer()
//                     ],
//                   ),
//                 ),
//                 flexibleSpace: FlexibleSpaceBar(
//                   background: Container(
//                     color: white,
//                     child: Stack(
//                       children: <Widget>[
//                         Container(
//                           height: MediaQuery.of(context).size.height * 0.22,
//                           decoration: const BoxDecoration(
//                             gradient: LinearGradient(
//                                 colors: <Color>[websiteBlue, websiteBlue]),
//                             borderRadius: BorderRadius.only(
//                                 bottomRight: Radius.circular(20.0),
//                                 bottomLeft: Radius.circular(20.0)),
//                           ),
//                         ),
//                         Column(
//                           children: <Widget>[
//                             Container(
//                               alignment: Alignment.center,
//                               margin: EdgeInsets.only(top: (h * 0.12)),
//                               child: Column(
//                                 children: <Widget>[
//                                   Container(
//                                     height: h * 0.2,
//                                     width: w * 0.6,
//                                     decoration: classinfo.logo.isEmpty
//                                         ? boxDecoration(
//                                             showShadow: true,
//                                             imageExsit: true,
//                                             imagetype: 0,
//                                             boxfit:BoxFit.cover,
//                                             imageAsset: 'assets/images/class.png',
//                                             radius: 10)
//                                         : boxDecoration(
//                                             showShadow: true,
//                                             imageExsit: true,
//                                             imagetype: 1,
//                                             boxfit: BoxFit.cover,
//                                             imageUrl: personImagesPath+classinfo.logo,
//                                             radius: 10),
//                                   ),
//                                   SizedBox(height: 8),
//                                   text(element.name,
//                                       textColor: color3,
//                                       fontSize: f * 1.3,
//                                       fontSizesLevel: 1),
//                                   SizedBox(height: 4)
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SliverPersistentHeader(
//                 delegate: _SliverAppBarDelegate(
//                   TabBar(
//                     labelColor: websiteBlue,
//                     indicatorColor: websiteBlue,
//                     unselectedLabelColor: color3.withOpacity(0.4),
//                     tabs: [
//                       Tab(text: 'عن المحاظرة'),
//                       Tab(text: 'بنك الأسئلة'),
//                       Tab(text: 'المرفقات'),
//                     ],
//                   ),
//                 ),
//                 pinned: true,
//               ),
//             ];
//           },
//           body: TabBarView(
//             children: [
//               AboutLecture(
//                 element: element,
//                 classid: classinfo.id,
//               ),
//               Qutions(
//                 element: element,
//               ),
//               Files(
//                 element: element,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   FloatingActionButton floatingActionButton() {
//     return FloatingActionButton.extended(
//       onPressed: () {
//         // Navigator.of(context).push(
//         //     MaterialPageRoute(builder: (BuildContext context) => AddTrip()));
//       },
//       backgroundColor: green,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       foregroundColor: white,
//       icon: Icon(Icons.file_present),
//       label: Text("إضافة مرفق"),
//     );
//   }
// }

// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   _SliverAppBarDelegate(this._tabBar);

//   final TabBar _tabBar;

//   @override
//   double get minExtent => _tabBar.preferredSize.height;

//   @override
//   double get maxExtent => _tabBar.preferredSize.height;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return new Container(
//       child: Container(
//           margin: EdgeInsets.only(left: 16, right: 16),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(10.0)),
//               color: gray2),
//           child: _tabBar),
//     );
//   }

//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return false;
//   }
// }
