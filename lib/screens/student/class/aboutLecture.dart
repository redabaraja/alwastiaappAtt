import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_file/open_file.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';
import 'package:alwastia/bloc/teacher/getMyFilesBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyFilesBloc/event.dart';
import 'package:alwastia/bloc/teacher/getMyFilesBloc/model.dart';
import 'package:alwastia/bloc/teacher/getMyFilesBloc/state.dart';
import 'package:alwastia/bloc/teacher/getMyLecturesBloc/model.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

// import 'package:url_launcher/url_launcher.dart';

class AboutLecture extends StatefulWidget {
  late LectureModel element;
  late ClassModel2 classInfo;
  AboutLecture({required this.element, required this.classInfo});
  @override
  State<AboutLecture> createState() =>
      _AboutLectureState(element: element, classInfo: classInfo);
}

class _AboutLectureState extends State<AboutLecture>
    with AutomaticKeepAliveClientMixin {
  late LectureModel element;
  late ClassModel2 classInfo;

  _AboutLectureState({required this.element, required this.classInfo});
  String progress = '0';
  bool isDownloading = false;
  int selected = 0;
  String selectedname = '';
  List<bool> fileExsit = [];
  List<String> filePath = [];
  Dio dio = Dio();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetFilesBloc>(context)
        .add(GetMyFiles(lectureid: element.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 16, top: 20, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              infoline("اسم المحاظرة", element.name),
              spaceBetweenBtns(),
              infoline("الوصف", element.descr),
              Container(
                height: h * 0.02,
              ),
              lisview(),
            ],
          ),
        ),
      ),
    );
  }

  Widget lisview() {
    return BlocBuilder<GetFilesBloc, GetFilesState>(builder: (context, state) {
      if (state is LoadingState2) {
        return Container(
          width: w,
          height: h * 0.8,
          child: Center(
            child: Container(
              height: h * 0.04,
              width: h * 0.04,
              child: CircularProgressIndicator(
                color: blue,
                strokeWidth: 3,
              ),
            ),
          ),
        );
      } else if (state is MyFiles) {
        if (state.connection) {
          fileExsit = state.fileExsit;
          filePath = state.filePath;
          return ListView.builder(
            itemCount: state.data.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              // for (var item in state.data) {
              //   filePath.add(path.join(filesPath, item.fileName));
              //   File file=File(path.join());
              //   if()
              // }
              return fileCard(state.data[index], index);
            },
          );
        } else {
          return Container(
            width: w,
            height: h * 0.65,
            child: Column(
              children: [
                Container(
                  height: h * 0.5,
                  width: w * 0.8,
                  decoration: boxDecoration(
                      imageExsit: true,
                      bgColor: Colors.transparent,
                      imageAsset: 'assets/images/noNet2.png',
                      boxfit: BoxFit.contain),
                ),
                Container(
                  height: h * 0.02,
                ),
                Material(
                  child: InkWell(
                      splashColor: white.withOpacity(0.5),
                      onTap: () {
                        BlocProvider.of<GetFilesBloc>(context)
                            .add(GetMyFiles(lectureid: element.id));
                      },
                      child: buttons('أعد المحاولة', 1, blue)),
                )
              ],
            ),
          );
        }
      } else {
        return Container();
      }
    });
  }

  Container fileCard(FileModel data, int index) {
    return Container(
      height: h * 0.1,
      width: w * 0.9,
      decoration: boxDecoration(bgColor: white, showShadow: true, radius: 10),
      child: Row(
        children: [
          Container(
            width: w * 0.2,
            decoration: boxDecoration(radius: 10, bgColor: blue),
            child: Center(
              child: text(deletedot(data.fileType),
                  fontSize: f,
                  fontSizesLevel: 1,
                  textColor: white,
                  isBold: true),
            ),
          ),
          Container(
            width: w * 0.13,
            child: Center(
              child: Container(
                height: h * 0.05,
                width: h * 0.05,
                decoration: boxDecoration(color: blue, radius: 100),
                child: IconButton(
                  icon: Center(
                      child: isDownloading && selected == index
                          ? text(progress,
                              fontSize: f, fontSizesLevel: 0, textColor: color3)
                          : fileExsit[index]
                              ? text('فتح',
                                  fontSize: f,
                                  fontSizesLevel: 0,
                                  textColor: green)
                              : Icon(
                                  Icons.download,
                                  color: blue,
                                )),
                  onPressed: () async {
                    if (fileExsit[index]) {
                      await OpenFile.open(filePath[index]);
                    } else {
                      var dir = await getApplicationDocumentsDirectory();
                      setState(() {
                        selectedname = path.join(dir.path, data.fileName);
                        selected = index;
                        isDownloading = true;
                        download(
                            path.join(filesPath, data.fileName), data.fileName);
                      });
                    }
                  },
                ),
              ),
            ),
          ),
          Container(
            width: w * 0.57 - 2,
            child: Column(
              children: [
                Container(
                  height: h * 0.07 - 2,
                  padding: EdgeInsets.only(right: w * 0.03, top: h * 0.03),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      data.title,
                      style: TextStyle(
                          color: color3,
                          fontSize: f,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  height: h * 0.03,
                  padding: EdgeInsets.only(right: w * 0.03, top: h * 0.01),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      data.date,
                      style: TextStyle(
                        color: color3,
                        fontSize: f * 0.9,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
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
      // height: h * 0.08,
      width: w,
      color: white,
      child: Row(
        children: [
          Container(
            width: w * 0.6,
            child: Center(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(value,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: f,
                        fontWeight: FontWeight.bold,
                        color: color3)),
              ),
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

  @override
  bool get wantKeepAlive => true;

  deletedot(String ext) {
    String ex = '';
    for (var i = 0; i < ext.length; i++) {
      if (ext[i] != '.') {
        ex += ext[i];
      }
    }
    return ex;
  }

  Future download(String fileUrl, String fileName) async {
    Directory dir = await getApplicationDocumentsDirectory();
    await requestpermission();
    final savePath = path.join(dir.path, fileName);
    await startDownload(fileUrl, savePath);
  }

  Future requestpermission() async {
    return await [Permission.storage].request();
  }

  Future startDownload(String urlPath, String savePath) async {
    Map<String, dynamic> result = {
      "isSuccsess": false,
      "filePath": null,
      "error": null
    };
    try {
      print('strating downlading');
      var res = await dio.download(urlPath, savePath,
          onReceiveProgress: _onReceiveProgress);
      result['isSuccsess'] = res.statusCode == 200;
      result['filePath'] = savePath;
    } catch (e) {
      result['error'] = e.toString();
    } finally {
      setState(() {
        isDownloading = false;
        fileExsit[selected] = true;
        // filePath[selected] = selectedname;
        progress = '0';
        selected = 0;
      });
    }
  }

  Future _onReceiveProgress(int receive, int total) async {
    if (total != -1) {
      setState(() {
        progress = (receive / total * 100).toStringAsFixed(0) + "%";
      });
    }
  }
}
