import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/TeacherModle.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/student/profileBloc/bloc.dart';
import 'package:alwastia/bloc/student/profileBloc/event.dart';
import 'package:alwastia/bloc/student/profileBloc/localdata.dart';
import 'package:alwastia/bloc/student/profileBloc/state.dart';
import 'package:alwastia/consts.dart';
import 'package:alwastia/screens/student/profile/logout.dart';

import 'package:flutter/material.dart';
import 'package:alwastia/screens/teacher/profile/updateTeacherInfo.dart';

class TeacherInfo extends StatefulWidget {
  @override
  State<TeacherInfo> createState() => _TeacherInfoState();
}

class _TeacherInfoState extends State<TeacherInfo> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProFileBloc>(context).add(GetUserInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 16, top: 20, right: 16),
        child: SingleChildScrollView(
          child:
              BlocBuilder<ProFileBloc, ProfileState>(builder: (context, state) {
            return Column(
              children: [
                infoline("الإيميل", state is UserInfo ? state.data.email : ''),
                infoline(
                    "رقم الجوال", state is UserInfo ? state.data.number : ''),
                infoline("العنوان", state is UserInfo ? state.data.adress : ''),
                // infoline("التخصص", "بكلاريوس علوم حاسوب"),
                Container(
                  height: h * 0.05,
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => UpdateTeacherInfo(
                                data: TeacherModle(
                                    name: state is UserInfo
                                        ? state.data.name
                                        : '',
                                    address: state is UserInfo
                                        ? state.data.adress
                                        : '',
                                    degree: state is UserInfo
                                        ? state.data.major
                                        : '',
                                    id: state is UserInfo ? state.data.id : '',
                                    password: "snxis",
                                    phone: state is UserInfo
                                        ? state.data.number
                                        : '',
                                    username: state is UserInfo
                                        ? state.data.email
                                        : ''),
                              )));
                    },
                    child: buttons('تعديل المعلومات الشخصية', 0, green)),

                spaceBetweenBtns(),
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => Logout()));
                    },
                    child: buttons('تسجيل الخروج', 0, Colors.red.shade300)),
              ],
            );
          }),
        ),
      ),
    );
  }

  Container spaceBetweenBtns() {
    return Container(
      height: h * 0.01,
    );
  }

  Material buttons(String txt, int click, Color color) {
    return Material(
      child: Container(
        height: h * 0.07,
        width: w * 0.7,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3))
          ],
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color,
                color,
              ]),
        ),
        child: Center(
          child: Text(txt,
              style: TextStyle(
                  fontSize: f, fontWeight: FontWeight.bold, color: white)),
        ),
      ),
    );
  }

  Container infoline(String key, String value) {
    return Container(
      height: h * 0.08,
      width: w,
      color: white,
      child: Row(
        children: [
          Container(
            width: w * 0.6,
            child: Center(
              child: Text(value,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: f, fontWeight: FontWeight.bold, color: color3)),
            ),
          ),
          Container(
            width: w * 0.3,
            child: Center(
              child: Text(key,
                  style: TextStyle(
                      fontSize: f, fontWeight: FontWeight.bold, color: color3)),
            ),
          )
        ],
      ),
    );
  }
}
