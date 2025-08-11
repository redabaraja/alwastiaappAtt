import 'package:alwastia/screens/student/resetPassword.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/student/profileBloc/bloc.dart';
import 'package:alwastia/bloc/student/profileBloc/localdata.dart';
import 'package:alwastia/bloc/student/profileBloc/model.dart';
import 'package:alwastia/bloc/student/profileBloc/state.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/screens/student/profile/UpdateStudentInfo.dart';
import 'package:alwastia/screens/student/profile/logout.dart';

class PageOne1 extends StatefulWidget {
  @override
  State<PageOne1> createState() => _PageOne1State();
}

class _PageOne1State extends State<PageOne1> {
  UserModel userinfo = UserModel(
      email: '...',
      name: '...',
      number: '...',
      role: '...',
      adress: '...',
      logo: '...',
      college: '...',
      dept: '...',
      level: '...',
      major: '...',
      id: '...');

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProFileBloc, ProfileState>(
      listener: (context, state) => {
        if (state is UserInfo)
          {
            setState(() {
              userinfo = state.data;
            })
          }
      },
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(left: 16, top: 20, right: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                infoline("الإيميل",
                    userinfo.email == null ? '....' : userinfo.email),
                infoline("رقم الجوال",
                    userinfo.number == null ? '....' : userinfo.number),
                infoline("العنوان",
                    userinfo.adress == null ? '....' : userinfo.adress),
                infoline("المستوى",
                    userinfo.level == null ? '....' : userinfo.level),
                infoline(
                    "القسم", userinfo.dept == null ? '....' : userinfo.dept),
                infoline(
                    "التخصص", userinfo.major == null ? '....' : userinfo.major),
                infoline("الكلية",
                    userinfo.college == null ? '....' : userinfo.college),
                Container(
                  height: h * 0.05,
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ResetPassword()));
                    },
                    child: buttons('تعديل كلمة المرور', 0, blue)),
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
            ),
          ),
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
