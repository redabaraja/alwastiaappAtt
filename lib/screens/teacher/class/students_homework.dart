import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:alwastia/bloc/teacher/getHomeWorkStdBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getHomeWorkStdBloc/event.dart';
import 'package:alwastia/bloc/teacher/getHomeWorkStdBloc/state.dart';
import 'package:alwastia/bloc/teacher/getMyClassesBloc/model.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';

class ClassStudentsHomeWork extends StatefulWidget {
  late ClassModel element;
  late int assignmentId;
  ClassStudentsHomeWork({required this.element, required this.assignmentId});

  @override
  State<ClassStudentsHomeWork> createState() =>
      _ClassStudentsHomeWorkState(element: element, assignmentId: assignmentId);
}

class _ClassStudentsHomeWorkState extends State<ClassStudentsHomeWork> {
  late ClassModel element;
  late int assignmentId;
  _ClassStudentsHomeWorkState(
      {required this.element, required this.assignmentId});
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetHomeWorkStudentsBloc>(context)
        .add(GetMyHomeWorkStudents(assignmentId: assignmentId));
  }

  int itemindexforClosing = 0;
  List<bool> stdState = [];
  String progress = '0';
  bool isDownloading = false;
  int selected = 0;
  String selectedname = '';
  List<bool> fileExsit = [];
  List<String> filePath = [];
  Dio dio = Dio();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<GetHomeWorkStudentsBloc, GetHomeWorkStudentsState>(
          listener: (context, state) => {if (state is MyHomeWorkStudents) {}},
          child: BlocBuilder<GetHomeWorkStudentsBloc, GetHomeWorkStudentsState>(
              builder: (context, state) {
            String stdCount = '';
            state is MyHomeWorkStudents
                ? stdCount = state.data.length.toString()
                : '';
            if (state is MyHomeWorkStudents) {
              fileExsit = state.fileExsit;
              filePath = state.filePath;
            }

            return Column(
              children: [
                Container(
                  height: h * 0.1,
                  width: w,
                  child: Center(
                    child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: text(('عدد من سلم الواجب:' + " " + stdCount),
                            fontSize: f,
                            fontSizesLevel: 1,
                            textColor: color3,
                            isBold: true)),
                  ),
                ),
                state is LoadingState
                    ? Container(
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
                      )
                    : state is MyHomeWorkStudents
                        ? Container(
                            height: h * 0.8,
                            width: w,
                            child: ListView.builder(
                              itemCount: state.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Container(
                                      height: h * 0.12,
                                      width: w,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: w * 0.02,
                                          ),
                                          Container(
                                            height: h * 0.06,
                                            width: h * 0.06,
                                            child: InkWell(
                                              onTap: () async {
                                                if (fileExsit[index]) {
                                                  await OpenFile.open('');
                                                } else {
                                                  var dir =
                                                      await getApplicationDocumentsDirectory();
                                                  setState(() {
                                                    selectedname = path.join(
                                                        dir.path,
                                                        state.data[index]
                                                            .fileName);
                                                    selected = index;
                                                    isDownloading = true;
                                                    download(
                                                        path.join(
                                                            filesPath,
                                                            state.data[index]
                                                                .fileName),
                                                        state.data[index]
                                                            .fileName);
                                                  });
                                                }
                                              },
                                              child: Container(
                                                height: h * 0.08,
                                                width: w * 0.2,
                                                margin: EdgeInsets.only(
                                                    top: h * 0.01),
                                                decoration: boxDecoration(
                                                    radius: 10,
                                                    bgColor: websiteBlue,
                                                    showShadow: true),
                                                child: Center(
                                                  child: text(
                                                      isDownloading &&
                                                              selected == index
                                                          ? progress
                                                          : fileExsit[index]
                                                              ? 'فتح'
                                                              : "تنزيل",
                                                      fontSize: f,
                                                      textColor: white,
                                                      isBold: true),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            height: h * 0.12,
                                            width: w * 0.6,
                                            alignment: Alignment.centerRight,
                                            child: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Column(
                                                children: [
                                                  Spacer(),
                                                  Container(
                                                    width: w * 0.6,
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: text(
                                                        state.data[index].name,
                                                        fontSize: f,
                                                        fontSizesLevel: 1,
                                                        isBold: true,
                                                        textaligntype: 2,
                                                        textColor: color3),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    width: w * 0.6,
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: text(
                                                        "تم التسليم بتاريخ ${state.data[index].uploadDate}",
                                                        fontSize: f,
                                                        fontSizesLevel: 0,
                                                        textColor: color3),
                                                  ),
                                                  Spacer()
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: w * 0.04,
                                          ),
                                          Container(
                                            height: h * 0.12,
                                            width: w * 0.2,
                                            child: Center(
                                                child: state.data[index].logo ==
                                                        null
                                                    ? Container(
                                                        height: h * 0.08,
                                                        width: h * 0.08,
                                                        decoration: boxDecoration(
                                                            radius: 100,
                                                            color: blue,
                                                            imageExsit: true,
                                                            boxfit:
                                                                BoxFit.cover,
                                                            imageAsset:
                                                                'assets/images/person.png'),
                                                      )
                                                    : Container(
                                                        height: h * 0.08,
                                                        width: h * 0.08,
                                                        decoration: boxDecoration(
                                                            radius: 100,
                                                            color: blue,
                                                            boxfit:
                                                                BoxFit.cover,
                                                            imageExsit: true,
                                                            imagetype: 1,
                                                            imageUrl:
                                                                personImagesPath +
                                                                    state
                                                                        .data[
                                                                            index]
                                                                        .logo),
                                                      )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      color: color3.withOpacity(0.1),
                                    )
                                  ],
                                );
                              },
                            ),
                          )
                        : Container()
              ],
            );
          }),
        ),
      ),
    );
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
