// import 'package:cached_network_image/cached_network_image.dart';
import 'package:alwastia/screens/student/profile/logout.dart';
import 'package:alwastia/screens/student/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';
import 'package:alwastia/consts.dart';
import 'package:alwastia/screens/student/class/aboutclass.dart';
import 'package:alwastia/screens/student/class/lectures.dart';
import 'package:alwastia/screens/student/class/otherMenu2.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/screens/student/class/marksMenu.dart';
import 'package:alwastia/bloc/student/profileBloc/localdata.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';

import 'package:alwastia/widgets/text.dart';

class ClassRoom extends StatefulWidget {
  late ClassModel2 element;
  ClassRoom({required this.element});
  @override
  ClassRoomState createState() => ClassRoomState(element: element);
}

class ClassRoomState extends State<ClassRoom> {
  late ClassModel2 element;
  ClassRoomState({required this.element});
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        initialIndex: 1,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.34 + 60,
                floating: false,
                pinned: true,
                titleSpacing: 0,
                backgroundColor: innerBoxIsScrolled ? blue : blue,
                actionsIconTheme: IconThemeData(opacity: 0.0),
                title: Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Spacer(),
                      Text(
                        'جامعة الوسطية',
                        style: TextStyle(color: white),
                      ),
                      Spacer(),
                      SizedBox(
                        width: w * 0.1,
                      )
                    ],
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: white,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.22,
                          decoration: const BoxDecoration(
                            gradient:
                                LinearGradient(colors: <Color>[blue, blue]),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0)),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: h * 0.1,
                              width: w,
                              margin: EdgeInsets.only(bottom: 2),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: w * 0.03,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      LocalUserInfo hive1 = LocalUserInfo();
                                      LocalData hive2 = LocalData();
                                      await hive1.openBox();
                                      await hive2.openBox();
                                      await hive1.userinfoBox.clear();
                                      await hive2.userBox.clear();
                                      await hive1.userinfoBox.close();
                                      await hive2.userBox.close();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Logout()));
                                    },
                                    child: Container(
                                      height: h * 0.1,
                                      width: w * 0.3,
                                      child: Column(
                                        children: [
                                          Spacer(),
                                          Icon(
                                            Icons.logout_outlined,
                                            color: white,
                                            size: 20,
                                          ),
                                          text('تسجيل الخروج',
                                              fontSize: f,
                                              fontSizesLevel: -2,
                                              textColor: white,
                                              isBold: true),
                                          SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Profile()));
                                    },
                                    child: Container(
                                      height: h * 0.1,
                                      width: w * 0.3,
                                      child: Column(
                                        children: [
                                          Spacer(),
                                          Icon(
                                            Icons.person,
                                            color: white,
                                            size: 20,
                                          ),
                                          text('الملف الشخصي',
                                              fontSize: f,
                                              fontSizesLevel: -2,
                                              textColor: white,
                                              isBold: true),
                                          SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: w * 0.03,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: (h * 0.12)),
                              child: Column(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Profile()));
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: white,
                                      radius: h * 0.08,
                                      // foregroundImage: NetworkToFileImage(
                                      //     url: baseUrl3 + state.data.logo,
                                      //     file: state.file),
                                      child: CircleAvatar(
                                          backgroundColor: white,
                                          backgroundImage: AssetImage(
                                              'assets/images/person.png'),
                                          radius: h * 0.08),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  text('سالم احمد سالم باجري',
                                      textColor: color3,
                                      fontSize: f * 1.3,
                                      fontSizesLevel: 1),
                                  text('المستوى الخامس',
                                      fontSize: f,
                                      textColor: color3.withOpacity(0.7)),
                                  text('كلية الحقوق والقانون',
                                      fontSize: f,
                                      textColor: color3.withOpacity(0.7)),
                                  SizedBox(height: 8)
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: blue,
                    indicatorColor: blue,
                    unselectedLabelColor: color3.withOpacity(0.4),
                    tabs: [
                      Tab(text: 'التحضير'),
                      Tab(text: 'النتائج'),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              // lectures

              // Quteions
              AboutClass(
                element: element,
              ),
              MarksMenu(element: element),
              // Lectures(
              //   element: element,
              // ),

              // notis
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: gray2),
          child: _tabBar),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
