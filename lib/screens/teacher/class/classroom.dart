// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/teacher/classInfoBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/classInfoBloc/event.dart';
import 'package:alwastia/bloc/teacher/classInfoBloc/state.dart';
import 'package:alwastia/bloc/teacher/getMyClassesBloc/model.dart';
import 'package:alwastia/consts.dart';
import 'package:alwastia/screens/teacher/class/aboutclass.dart';
import 'package:alwastia/screens/teacher/class/studentsMenu2.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';

class ClassRoom extends StatefulWidget {
  late ClassModel element;
  late BuildContext conxt;
  late bool isClosing;
  ClassRoom(
      {required this.element, required this.conxt, required this.isClosing});
  @override
  ClassRoomState createState() =>
      ClassRoomState(element: element, conxt: conxt, isClosing: isClosing);
}

class ClassRoomState extends State<ClassRoom> {
  late ClassModel element;
  late BuildContext conxt;
  late bool isClosing;
  ClassRoomState(
      {required this.element, required this.conxt, required this.isClosing});
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    print("this is the class id : " + element.id.toString());

    return Scaffold(
      body: DefaultTabController(
        // length: 2,
        length: 2,
        // initialIndex: 2,
        initialIndex: 1,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.3 + 60,
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
                        'جامعة الوسيطة',
                        style: TextStyle(color: white),
                      ),
                      Spacer()
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
                                      BlocProvider.of<ClassInfoBloc>(context)
                                          .add(GetImage(
                                        id: element.id,
                                      ));
                                    },
                                    child: BlocBuilder<ClassInfoBloc,
                                            CLassInfoState>(
                                        builder: (context, state) {
                                      if (state is LoadingState) {
                                        return Container(
                                          height: h * 0.2,
                                          width: w * 0.6,
                                          decoration: boxDecoration(
                                            radius: 8,
                                            showShadow: true,
                                            bgColor: white,
                                            boxfit: BoxFit.cover,
                                          ),
                                          child: Center(
                                            child: Container(
                                              height: h * 0.03,
                                              width: h * 0.03,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 3,
                                                color: blue,
                                              ),
                                            ),
                                          ),
                                        );
                                      } else if (state is GetClassImage) {
                                        return Container(
                                          height: h * 0.2,
                                          width: w * 0.6,
                                          decoration: boxDecoration(
                                              radius: 8,
                                              showShadow: true,
                                              imageExsit: true,
                                              imagetype: 2,
                                              boxfit: BoxFit.cover,
                                              imagepath: state.imagePath),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              width: w * 0.6,
                                              height: h * 0.03,
                                              decoration: BoxDecoration(
                                                  color: color3
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  8),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  8))),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  Icons.camera_alt,
                                                  color: white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          height: h * 0.2,
                                          width: w * 0.6,
                                          decoration: element.image.isEmpty
                                              ? boxDecoration(
                                                  radius: 8,
                                                  showShadow: true,
                                                  imageExsit: true,
                                                  imagetype: 0,
                                                  boxfit: BoxFit.cover,
                                                  imageAsset:
                                                      'assets/images/class.png')
                                              : boxDecoration(
                                                  radius: 8,
                                                  showShadow: true,
                                                  imageExsit: true,
                                                  imagetype: 1,
                                                  // boxfit: BoxFit.cover,
                                                 imageUrl: baseUrl3+'/'+element.image),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              width: w * 0.6,
                                              height: h * 0.03,
                                              decoration: BoxDecoration(
                                                  color: color3
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  8),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  8))),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  Icons.camera_alt,
                                                  color: white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    }),
                                  ),
                                  SizedBox(height: 8),
                                  text(element.name,
                                      textColor: color3,
                                      fontSize: f * 1.3,
                                      fontSizesLevel: 1),
                                  SizedBox(height: 4)
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
                      Tab(text: 'معلومات'),
                      // Tab(text: 'المحاضرات'),
                      Tab(text: 'العمليات'),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              AboutClass(
                element: element,
                isCLosing: isClosing,
              ),

              // Lectures(
              //   element: element,
              //   contx: conxt,
              // ),
              StudentsMenu2(element: element),
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
