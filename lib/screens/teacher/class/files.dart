import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_file/open_file.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:alwastia/bloc/teacher/createFileBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/createFileBloc/event.dart';
import 'package:alwastia/bloc/teacher/createFileBloc/state.dart';
import 'package:alwastia/bloc/teacher/getMyFilesBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyFilesBloc/event.dart';
import 'package:alwastia/bloc/teacher/getMyFilesBloc/state.dart';
import 'package:alwastia/bloc/teacher/getMyLecturesBloc/model.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class Files extends StatefulWidget {
  late LectureModel element;
  Files({required this.element});
  @override
  State<Files> createState() => _FilesState(element: element);
}

class _FilesState extends State<Files> with AutomaticKeepAliveClientMixin {
  late LectureModel element;
  _FilesState({required this.element});
  var filenamecontroller = TextEditingController();
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
    print('build yes');
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
          margin: EdgeInsets.only(left: 16, top: 20, right: 16),
          child: listview()),
    );
  }

  @override
  bool get wantKeepAlive => true;
  Widget listview() {
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
        fileExsit = state.fileExsit;
        filePath = state.filePath;
        if (state.connection) {
          return Container(
            width: w,
            height: h * 0.9,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  height: h * 0.22,
                  margin: EdgeInsets.only(bottom: h * 0.03),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                    child: Container(
                      height: h * 0.22,
                      decoration: boxDecoration(radius: 10, showShadow: true),
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: w / 3,
                                height: w / 2.8,
                                decoration: state is MyFiles
                                    ? getExtnumber(deletedot(
                                                state.data[index].fileType)) ==
                                            0
                                        ? boxDecoration(
                                            radius: 8,
                                            showShadow: true,
                                            imageExsit: true,
                                            imagetype: 1,
                                            boxfit: BoxFit.cover,
                                            imageUrl: filesPath +
                                                state.data[index].fileName)
                                        :
                                        // ///////////////// //////////////////
                                        getExtnumber(deletedot(state
                                                    .data[index].fileType)) ==
                                                1
                                            ? boxDecoration(
                                                radius: 8,
                                                showShadow: true,
                                                imageExsit: true,
                                                imagetype: 0,
                                                boxfit: BoxFit.cover,
                                                imageAsset:
                                                    'assets/images/pdf.png')
                                            : getExtnumber(deletedot(state
                                                        .data[index]
                                                        .fileType)) ==
                                                    2
                                                ? boxDecoration(
                                                    radius: 8,
                                                    showShadow: true,
                                                    imageExsit: true,
                                                    imagetype: 0,
                                                    boxfit: BoxFit.cover,
                                                    imageAsset:
                                                        'assets/images/pp.png')
                                                : getExtnumber(deletedot(state
                                                            .data[index]
                                                            .fileType)) ==
                                                        3
                                                    ? boxDecoration(
                                                        radius: 8,
                                                        showShadow: true,
                                                        imageExsit: true,
                                                        imagetype: 0,
                                                        boxfit: BoxFit.cover,
                                                        imageAsset:
                                                            'assets/images/word.png')
                                                    : boxDecoration(
                                                        radius: 8,
                                                        showShadow: true,
                                                        imageExsit: true,
                                                        imagetype: 0,
                                                        boxfit: BoxFit.cover,
                                                        imageAsset:
                                                            'assets/images/file.png')

                                    ///////////        // ///////////////////
                                    : boxDecoration(
                                        radius: 8,
                                        showShadow: true,
                                        imageExsit: true,
                                        imagetype: 0,
                                        boxfit: BoxFit.cover,
                                        imageAsset: 'assets/images/file.png')),
                            Container(
                              width: w - (w / 3) - 68,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: new BorderRadius.only(
                                                bottomRight:
                                                    const Radius.circular(16.0),
                                                topRight: const Radius.circular(
                                                    16.0)),
                                          ),
                                          padding:
                                              EdgeInsets.fromLTRB(8, 2, 8, 2),
                                          child: text(
                                              index % 2 == 0 ? "فتح" : "إنضمام",
                                              textColor: Colors.transparent,
                                              fontSize: f,
                                              fontSizesLevel: 0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        text(state.data[index].title,
                                            textColor: color3,
                                            fontSize: f * 1.2,
                                            textaligntype: 2,
                                            isBold: true),
                                        SizedBox(height: 4),
                                        text(
                                            deletedot(
                                                state.data[index].fileType),
                                            textaligntype: 2,
                                            fontSize: f),
                                        SizedBox(height: 4),
                                        text(state.data[index].date,
                                            fontSize: f,
                                            textaligntype: 2,
                                            maxLine: 1),
                                        // text(
                                        //     studentsNumbers2[index]
                                        //         .toString(),
                                        //     fontSize: f,
                                        //     textaligntype: 2,
                                        //     maxLine: 1),
                                        SizedBox(height: 4),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: h * 0.05,
                                    width: w - (w / 3) - 68,
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Container(
                                          height: h * 0.05,
                                          width: w * 0.2,
                                          margin:
                                              EdgeInsets.only(top: h * 0.01),
                                          decoration: boxDecoration(
                                              radius: 10,
                                              bgColor: websiteBlue,
                                              showShadow: true),
                                          child: Center(
                                            child: text("حذف",
                                                fontSize: f,
                                                textColor: white,
                                                isBold: true),
                                          ),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () async {
                                            if (fileExsit[index]) {
                                              await OpenFile.open(
                                                  filePath[index]);
                                            } else {
                                              var dir =
                                                  await getApplicationDocumentsDirectory();
                                              setState(() {
                                                selectedname = path.join(
                                                    dir.path,
                                                    state.data[index].fileName);
                                                selected = index;
                                                isDownloading = true;
                                                download(
                                                    path.join(
                                                        filesPath,
                                                        state.data[index]
                                                            .fileName),
                                                    state.data[index].fileName);
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: h * 0.05,
                                            width: w * 0.2,
                                            margin:
                                                EdgeInsets.only(top: h * 0.01),
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
                                        Spacer()
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: h * 0.02,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        margin: EdgeInsets.all(0),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Container(
            width: w,
            height: h * 0.8,
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

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        showModalBottomSheet(
            backgroundColor: white,
            isScrollControlled: true,
            barrierColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            context: context,
            builder: (context) => buildSheets(
                  h,
                  w,
                  f,
                ));
      },
      backgroundColor: green,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      foregroundColor: white,
      icon: Icon(Icons.file_present),
      label: Text("إضافة مرفق"),
    );
  }

  Widget buildSheets(double height, double width, double fontx) {
    print('build sheets');
    String filepath = '';
    String filetitle = "ملف";
    int ext = 4;
    bool showError = false;
    String errorString = '';
    return FractionallySizedBox(
      heightFactor: 0.88,
      child: StatefulBuilder(builder: (context, StateSetter setSheetState) {
        return BlocListener<CreateFileBloc, CreateFileState>(
          listener: (context, state) => {
            if (state is GetFileDone)
              {
                setSheetState(() {
                  filetitle = state.name;
                  filepath = state.filePath;
                  ext = state.ext;
                })
              }
            else if (state is CreateFileDone)
              {
                if (state.connection)
                  {
                    if (state.res)
                      {
                        BlocProvider.of<GetFilesBloc>(context)
                            .add(GetMyFiles(lectureid: element.id)),
                        setSheetState(() {
                          filenamecontroller.clear();
                          showError = true;
                          errorString = 'تم  اضافة المرفق  بنجاح';
                          Navigator.pop(context);
                        })
                      }
                    else
                      {
                        setSheetState(() {
                          showError = true;
                          errorString = 'حصل خطاء ما';
                        })
                      }
                  }
                else
                  {
                    setSheetState(() {
                      showError = true;
                      errorString = 'لا يوجد إتصال بالانترنت';
                    })
                  }
              }
          },
          child: Scaffold(
            body: Container(
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              height: height * 0.88,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 3),
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  // height: height * 0.41,
                  child: Column(
                    children: [
                      Container(
                        height: h * 0.05,
                      ),
                      addImage(filetitle),
                      Container(
                        height: h * 0.05,
                      ),
                     
                      buildTextField(
                          h, w, f, filenamecontroller, 'اسم المرفق', false),
                      Container(
                        height: h * 0.02,
                      ),
                      Container(
                        child: text('نوع الملف',
                            fontSize: f,
                            textColor: green,
                            isBold: true,
                            fontSizesLevel: 1),
                      ),
                      Container(
                        height: h * 0.07,
                        width: w,
                        child: Row(
                          children: [
                            Spacer(),
                            Container(
                              height: h * 0.07,
                              child: Center(
                                child: text('صورة',
                                    fontSize: f,
                                    fontSizesLevel: 1,
                                    isBold: true,
                                    textColor: green),
                              ),
                            ),
                            Container(
                              width: 10,
                            ),
                            Container(
                              height: h * 0.025,
                              width: h * 0.025,
                              decoration: boxDecoration(
                                  radius: 10,
                                  color: blue,
                                  bgColor:
                                      ext == 0 ? green : Colors.transparent),
                            ),
                            Spacer(),
                            Container(
                              height: h * 0.07,
                              child: Center(
                                child: text('pdf',
                                    fontSize: f,
                                    fontSizesLevel: 1,
                                    isBold: true,
                                    textColor: green),
                              ),
                            ),
                            Container(
                              width: 10,
                            ),
                            Container(
                              height: h * 0.025,
                              width: h * 0.025,
                              decoration: boxDecoration(
                                  radius: 10,
                                  color: blue,
                                  bgColor:
                                      ext == 1 ? green : Colors.transparent),
                            ),
                            Spacer(),
                            Container(
                              height: h * 0.07,
                              child: Center(
                                child: text('powerpoint',
                                    fontSize: f,
                                    fontSizesLevel: 1,
                                    isBold: true,
                                    textColor: green),
                              ),
                            ),
                            Container(
                              width: 10,
                            ),
                            Container(
                              height: h * 0.025,
                              width: h * 0.025,
                              decoration: boxDecoration(
                                  radius: 10,
                                  color: blue,
                                  bgColor:
                                      ext == 2 ? green : Colors.transparent),
                            ),
                            Spacer(),
                            Container(
                              height: h * 0.07,
                              child: Center(
                                child: text('word',
                                    fontSize: f,
                                    fontSizesLevel: 1,
                                    isBold: true,
                                    textColor: green),
                              ),
                            ),
                            Container(
                              width: 10,
                            ),
                            Container(
                              height: h * 0.025,
                              width: h * 0.025,
                              decoration: boxDecoration(
                                  radius: 10,
                                  color: blue,
                                  bgColor:
                                      ext == 3 ? green : Colors.transparent),
                            ),
                            Spacer()
                          ],
                        ),
                      ),
                      Container(
                        height: h * 0.05,
                      ),
                      InkWell(
                          onTap: () {
                            print('sss');
                            if (filepath.isEmpty) {
                              setSheetState(() {
                                showError = true;
                                errorString = "فضلا اختر  مرفق";
                              });
                            } else if (filenamecontroller.text.isEmpty) {
                              setSheetState(() {
                                showError = true;
                                errorString = "فضلا ادخل  اسم المرفق";
                              });
                            } else
                              BlocProvider.of<CreateFileBloc>(context).add(
                                  CreateFile(
                                      title: filenamecontroller.text,
                                      file: File(filepath),
                                      lectureid: element.id));
                          },
                          child: buttons('إضافة', 0, green)),
                      Container(height: h * 0.05),
                      showError
                          ? Container(
                              child: Center(
                                child: Text(errorString,
                                    style: TextStyle(
                                        color: Colors.red.shade200,
                                        fontSize: f,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget addImage(String title) {
    return InkWell(
      onTap: () {
        BlocProvider.of<CreateFileBloc>(context).add(GetFile());
      },
      child: Container(
        width: w,
        child: Center(
          child: Container(
            height: h * 0.2,
            width: w * 0.6,
            decoration:
                boxDecoration(showShadow: true, color: blue.withOpacity(0.2), radius: 5),
            child: Center(
              child: text(title,
                  fontSize: f,
                  fontSizesLevel: 1,
                  isBold: true,
                  textColor: green),
            ),
          ),
        ),
      ),
    );
  }

  Directionality buildTextField(double height, double width, double fontx,
      TextEditingController controller, String hint, bool secureWords) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: height * 0.07,
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.only(
            left: width * 0.03, right: width * 0.03, top: height * 0.01),
        decoration: boxDecoration(radius: 5, color: blue.withOpacity(0.2)),
        child: TextField(
          controller: controller,
          maxLines: 1,
          minLines: 1,
          textAlign: TextAlign.right,
          style: TextStyle(
              color: color3,
              fontFamily: 'DroidArabicKufi',
              fontSize: fontx - fontx * 0.1,
              fontWeight: FontWeight.bold),
          keyboardType: TextInputType.name,
          // textInputAction: TextInputAction.next,
          cursorColor: blue,
          decoration: InputDecoration(
            fillColor: white,
            filled: true,
            hintText: hint,
            hintStyle: TextStyle(
                color: Colors.grey,
                fontFamily: 'DroidArabicKufi',
                fontSize: fontx,
                fontWeight: FontWeight.bold),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15)),
          ),
          obscureText: secureWords,
        ),
      ),
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
        child: BlocBuilder<CreateFileBloc, CreateFileState>(
            builder: (context, state) {
          return state is LoadingState
              ? Center(
                  child: Container(
                    height: h * 0.03,
                    width: h * 0.03,
                    child: CircularProgressIndicator(
                      color: white,
                      strokeWidth: 3,
                    ),
                  ),
                )
              : Center(
                  child: Text(txt,
                      style: TextStyle(
                          fontSize: f,
                          fontWeight: FontWeight.bold,
                          color: white)),
                );
        }),
      ),
    );
  }

  getExtnumber(String ext) {
    if (ext == 'png' ||
        ext == 'jpg' ||
        ext == 'jpeg' ||
        ext == 'gif' ||
        ext == 'bmp') {
      print('img');
      return 0;
    } else if (ext == 'pdf') {
      print('pdf');
      return 1;
    } else if (ext == 'doc' || ext == 'docx') {
      print('docx');
      return 3;
    } else if (ext == 'ppt' || ext == 'pptx') {
      print('ppt');
      return 2;
    } else {
      print('file');
      return 4;
    }
  }

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
