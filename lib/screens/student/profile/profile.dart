// import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/profileBloc/bloc.dart';
import 'package:alwastia/bloc/student/profileBloc/event.dart';
import 'package:alwastia/bloc/student/profileBloc/model.dart';
import 'package:alwastia/bloc/student/profileBloc/state.dart';
import 'package:alwastia/consts.dart';
import 'package:alwastia/screens/student/profile/page1.dart';
import 'package:alwastia/widgets/text.dart';
import 'package:network_to_file_image/network_to_file_image.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProFileBloc>(context).add(GetUserInfo());
  }

  String name = '';
  String email = '';
  UserModel userinfo = UserModel(
      email: '',
      name: '',
      number: '',
      role: '',
      adress: '',
      logo: '',
      id: '',
      college: '',
      dept: '',
      level: '',
      major: '');

  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;

    // String name='a';
    // String email='b';

    return Scaffold(
      body: BlocListener<ProFileBloc, ProfileState>(
        listener: (context, state) => {
          if (state is UserInfo)
            {
              setState(() {
                name = state.data.name;
                email = state.data.email;
                userinfo = state.data;
              })
            }
        },
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
                        ' جامعة الوسطية',
                        style: TextStyle(color: white),
                      ),
                      Spacer()
                    ],
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: BlocBuilder<ProFileBloc, ProfileState>(
                      builder: (context, state) {
                    return Container(
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
                                        // BlocProvider.of<ProFileBloc>(context)
                                        //     .add(GetImage());
                                      },
                                      child: state is UserInfo
                                          ? Stack(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: white,
                                                  radius: h * 0.08,
                                                  foregroundImage:
                                                      NetworkToFileImage(
                                                          url: baseUrl3 +
                                                              state.data.logo,
                                                          file: state.file),
                                                  child: CircleAvatar(
                                                      backgroundColor: white,
                                                      backgroundImage: AssetImage(
                                                          'assets/images/person.png'),
                                                      radius: h * 0.08),
                                                ),
                                              ],
                                            )
                                          : state is GetProfileImage
                                              ? CircleAvatar(
                                                  backgroundColor: white,
                                                  radius: h * 0.08,
                                                  backgroundImage: FileImage(
                                                      File(state.imagePath)),
                                                )
                                              : state is LoadingState2
                                                  ? CircleAvatar(
                                                      backgroundColor: white,
                                                      child: Center(
                                                        child: Container(
                                                          height: h * 0.03,
                                                          width: h * 0.03,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: blue,
                                                            strokeWidth: 2,
                                                          ),
                                                        ),
                                                      ),
                                                      radius: h * 0.08)
                                                  : CircleAvatar(
                                                      backgroundColor: white,
                                                      backgroundImage: AssetImage(
                                                          'assets/images/person.png'),
                                                      radius: h * 0.08),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // BlocProvider.of<ProFileBloc>(context)
                                        //     .add(GetImage());
                                      },
                                      child: Container(
                                        height: h * 0.03,
                                        width: w,
                                        child: Center(
                                          child: Icon(Icons.camera_alt),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    text(
                                      name,
                                      textColor: color3,
                                      fontSize: f * 1.1,
                                    ),
                                    text(email,
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
                    );
                  }),
                ),
              ),
            ];
          },
          body: PageOne1(),
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
