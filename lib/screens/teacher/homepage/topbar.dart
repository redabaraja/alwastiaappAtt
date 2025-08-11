import 'package:flutter/material.dart';
import 'package:alwastia/consts.dart';
import 'package:alwastia/screens/teacher/homepage/homepage.dart';

class HomePageBar extends StatefulWidget {
  const HomePageBar({Key? key}) : super(key: key);

  @override
  State<HomePageBar> createState() => _HomePageBarState();
}

class _HomePageBarState extends State<HomePageBar> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            appBar(h, w, scaffoldKey, context),
            THomePage()
          ],
        ),
      ),
    );
  }
}
