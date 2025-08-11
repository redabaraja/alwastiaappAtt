import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/screens/teacher/homepage/activeclass.dart';
import 'package:alwastia/screens/teacher/homepage/nonactiveclass.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:flutter/services.dart';
import 'dart:io';


class THomePage extends StatefulWidget {
  const THomePage({Key? key}) : super(key: key);

  @override
  State<THomePage> createState() => _THomePageState();
}

class _THomePageState extends State<THomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () {
        if (Platform.isAndroid) {
          exit(0);
        } else {
          exit(0);
        }
        return Future.value(false);
      },
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          initialIndex: 1,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: h * 0.08,
                  floating: false,
                  pinned: true,
                  titleSpacing: 0,
                  backgroundColor: blue,
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
                        Spacer()
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      labelColor: websiteBlue,
                      indicatorColor: websiteBlue,
                      unselectedLabelColor: color3.withOpacity(0.4),
                      tabs: [
                        Tab(text: 'مقررات مغلقة'),
                        Tab(text: 'مقررات نشطة'),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                NonActiveClasses(),
                ActiveClasses(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (BuildContext context) => AddTrip()));
      },
      backgroundColor: green,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      foregroundColor: white,
      icon: Icon(Icons.file_present),
      label: Text("إضافة مرفق"),
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
          decoration: boxDecoration(radius: 5, showShadow: true),
          child: _tabBar),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
