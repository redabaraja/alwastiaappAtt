// // import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:network_to_file_image/network_to_file_image.dart';
// import 'dart:io';
// import 'package:alwastia/bloc/student/profileBloc/bloc.dart';
// import 'package:alwastia/bloc/student/profileBloc/event.dart';
// import 'package:alwastia/bloc/student/profileBloc/state.dart';
// import 'package:alwastia/consts.dart';
// import 'package:alwastia/screens/teacher/profile/teacherInfo.dart';
// import 'package:alwastia/widgets/text.dart';

// class TeacherProfile extends StatefulWidget {
//   @override
//   TeacherProfileState createState() => TeacherProfileState();
// }

// class TeacherProfileState extends State<TeacherProfile> {
//   String name = '';
//   String email = '';
//   String logo = '';
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<ProFileBloc>(context).add(GetUserInfo());
//   }

//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;

//     return BlocListener<ProFileBloc, ProfileState>(
//       listener: (context, state) => {
//         if (state is UserInfo)
//           {
//             setState(() {
//               name = state.name;
//               email = state.email;
//               logo = state.logo;
//             })
//           }
//       },
//       child: Scaffold(
//         body: NestedScrollView(
//           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//             return <Widget>[
//               SliverAppBar(
//                 expandedHeight: MediaQuery.of(context).size.height * 0.34 + 60,
//                 floating: false,
//                 pinned: true,
//                 titleSpacing: 0,
//                 backgroundColor: innerBoxIsScrolled ? blue : blue,
//                 actionsIconTheme: IconThemeData(opacity: 0.0),
//                 title: Container(
//                   height: 60,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Spacer(),
//                       Text(
//                         'المعلم الجامعي',
//                         style: TextStyle(color: white),
//                       ),
//                       Spacer()
//                     ],
//                   ),
//                 ),
//                 flexibleSpace: FlexibleSpaceBar(
//                   background: BlocBuilder<ProFileBloc, ProfileState>(
//                       builder: (context, state) {
//                     return Container(
//                       color: white,
//                       child: Stack(
//                         children: <Widget>[
//                           Container(
//                             height: MediaQuery.of(context).size.height * 0.22,
//                             decoration: const BoxDecoration(
//                               gradient: LinearGradient(
//                                   colors: <Color>[blue, darkblue]),
//                               borderRadius: BorderRadius.only(
//                                   bottomRight: Radius.circular(20.0),
//                                   bottomLeft: Radius.circular(20.0)),
//                             ),
//                           ),
//                           Column(
//                             children: <Widget>[
//                               Container(
//                                 alignment: Alignment.center,
//                                 margin: EdgeInsets.only(top: (h * 0.12)),
//                                 child: Column(
//                                   children: <Widget>[
                                   
//                                     InkWell(
//                                       onTap: () {
//                                         BlocProvider.of<ProFileBloc>(context)
//                                             .add(GetImage(
//                                                 name: state is UserInfo
//                                                     ? state.name
//                                                     : state is GetProfileImage
//                                                         ? state.name
//                                                         : '',
//                                                 email: state is UserInfo
//                                                     ? state.email
//                                                     : state is GetProfileImage
//                                                         ? state.email
//                                                         : ''));
//                                       },
//                                       child: state is UserInfo
//                                           ? CircleAvatar(
//                                               backgroundColor: white,
//                                               radius: h * 0.08,
//                                               foregroundImage:
//                                                   NetworkToFileImage(
//                                                       url: personImagesPath +
//                                                           logo,
//                                                       file: state.file),
//                                               child: CircleAvatar(
//                                                   backgroundColor: white,
//                                                   backgroundImage: AssetImage(
//                                                       'assets/images/person.png'),
//                                                   radius: h * 0.08),
//                                             )
//                                           : state is GetProfileImage
//                                               ? CircleAvatar(
//                                                   backgroundColor: white,
//                                                   radius: h * 0.08,
//                                                   backgroundImage: FileImage(
//                                                       File(state.imagePath)),
//                                                 )
//                                               : CircleAvatar(
//                                                   backgroundColor: white,
//                                                   backgroundImage: AssetImage(
//                                                       'assets/images/person.png'),
//                                                   radius: h * 0.08),
//                                     ),
//                                     SizedBox(height: 8),
//                                     text(
//                                       name,
//                                       textColor: color3,
//                                       fontSize: f * 1.1,
//                                     ),
//                                     text(email,
//                                         fontSize: f,
//                                         textColor: color3.withOpacity(0.7)),
//                                     SizedBox(height: 8)
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ];
//           },
//           body: TeacherInfo(),
//         ),
//       ),
//     );
//   }
// }
