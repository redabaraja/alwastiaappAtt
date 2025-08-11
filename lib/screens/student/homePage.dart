import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/LinkClassBloc/bloc.dart';
import 'package:alwastia/bloc/student/LinkClassBloc/event.dart';
import 'package:alwastia/bloc/student/LinkClassBloc/state.dart';
import 'package:alwastia/bloc/student/SearchForClassBloc/bloc.dart';
import 'package:alwastia/bloc/student/SearchForClassBloc/event.dart';
import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';
import 'package:alwastia/bloc/student/SearchForClassBloc/state.dart';
import 'package:alwastia/bloc/student/geLinkedClassesBloc/bloc.dart';
import 'package:alwastia/bloc/student/geLinkedClassesBloc/event.dart';
import 'package:alwastia/bloc/student/geLinkedClassesBloc/state.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alwastia/screens/student/class/classroom.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:alwastia/widgets/text.dart';
import 'package:flutter/services.dart';
import 'package:scan/scan.dart';
import 'dart:io';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var searchcontroller = TextEditingController();
  var passcodecontroller = TextEditingController();

  bool iswriting = false;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetLinkedClassesBloc>(context).add(GetLinkedClasses());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          print('it is here');
          if (Platform.isAndroid) {
            print('it is android');
            exit(0);
          } else {
            exit(0);
          }
          return Future.value(false);
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                appBar(h, w, scaffoldKey, context),
                // searchField(),
                // linkToClassBtn(),
                Container(
                  height: h * 0.02,
                ),
                listview(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listview() {
    return BlocBuilder<GetLinkedClassesBloc, GetLinkedClassesState>(
        builder: (context, state) {
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
      } else if (state is MyLinkedClasses) {
        if (state.connection) {
          if (state.data.isEmpty) {
            return Container(
              width: w,
              height: h * 0.8,
              child: Column(
                children: [
                  Spacer(),
                  Container(
                    height: h * 0.35,
                    width: w * 0.55,
                    decoration: boxDecoration(
                        imageExsit: true,
                        bgColor: Colors.transparent,
                        imageAsset: 'assets/images/noclasses.png',
                        boxfit: BoxFit.contain),
                  ),
                  Spacer(),
                ],
              ),
            );
          } else {
            return Container(
              width: w,
              height: h * 0.8,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index % 2 == 0) {
                    // _createBannerAd();
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        children: [
                          Container(
                            decoration:
                                boxDecoration(radius: 10, showShadow: true),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ClassRoom(
                                          element: state.data[index],
                                        )));
                              },
                              child: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                        width: w / 3,
                                        height: w / 2.8,
                                        decoration: boxDecoration(
                                            radius: 8,
                                            showShadow: true,
                                            imageExsit: true,
                                            imagetype: 0,
                                            boxfit: BoxFit.cover,
                                            imageAsset:
                                                'assets/images/class.png')),
                                    Container(
                                      width: w - (w / 3) - 35,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: blue,
                                                  borderRadius: new BorderRadius
                                                          .only(
                                                      bottomRight:
                                                          const Radius.circular(
                                                              16.0),
                                                      topRight:
                                                          const Radius.circular(
                                                              16.0)),
                                                ),
                                                padding: EdgeInsets.fromLTRB(
                                                    8, 2, 8, 2),
                                                child: text('فتح',
                                                    textColor: white,
                                                    fontSize: f,
                                                    fontSizesLevel: 0),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                                text(state.data[index].name,
                                                    textColor: color3,
                                                    fontSize: f * 1.2,
                                                    textaligntype: 2,
                                                    isBold: true),
                                                SizedBox(height: 4),
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: text(
                                                      state.data[index].teacher,
                                                      fontSize: f,
                                                      textaligntype: 2,
                                                      maxLine: 1),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                SizedBox(height: 4),
                                                SizedBox(height: 4),
                                              ],
                                            ),
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
                          // Container(
                          //   height: 5,
                          // ),
                          // Container(
                          //   height: h * 0.1,
                          //   margin: EdgeInsets.only(
                          //       top: h * 0.03, bottom: h * 0.02),
                          //   decoration: BoxDecoration(
                          //     color: lightBlue,
                          //     borderRadius: BorderRadius.circular(5),
                          //     boxShadow: [
                          //       BoxShadow(
                          //           color: Colors.grey.withOpacity(0.5),
                          //           spreadRadius: 0.2,
                          //           blurRadius: 0.2,
                          //           offset: Offset(0, 0))
                          //     ],
                          //   ),
                          //   child: AdWidget(
                          //     ad: _ad!,
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Container(
                        decoration: boxDecoration(radius: 10, showShadow: true),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => ClassRoom(
                                      element: state.data[index],
                                    )));
                          },
                          child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Row(
                              children: <Widget>[
                                Container(
                                    width: w / 3,
                                    height: w / 2.8,
                                    decoration: boxDecoration(
                                        radius: 8,
                                        showShadow: true,
                                        imageExsit: true,
                                        imagetype: 0,
                                        boxfit: BoxFit.cover,
                                        imageAsset: 'assets/images/class.png')),
                                Container(
                                  width: w - (w / 3) - 35,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              color: blue,
                                              borderRadius:
                                                  new BorderRadius.only(
                                                      bottomRight:
                                                          const Radius.circular(
                                                              16.0),
                                                      topRight:
                                                          const Radius.circular(
                                                              16.0)),
                                            ),
                                            padding:
                                                EdgeInsets.fromLTRB(8, 2, 8, 2),
                                            child: text('فتح',
                                                textColor: white,
                                                fontSize: f,
                                                fontSizesLevel: 0),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            text(state.data[index].name,
                                                textColor: color3,
                                                fontSize: f * 1.2,
                                                textaligntype: 2,
                                                isBold: true),
                                            SizedBox(height: 4),
                                            Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: text(
                                                  state.data[index].teacher,
                                                  fontSize: f,
                                                  textaligntype: 2,
                                                  maxLine: 1),
                                            ),
                                            SizedBox(height: 4),
                                          ],
                                        ),
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
                  }
                },
              ),
            );
          }
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
                        BlocProvider.of<GetLinkedClassesBloc>(context)
                            .add(GetLinkedClasses());
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

  Padding cardBody(
      int index,
      BuildContext context,
      String imagePath,
      String title,
      String instor,
      String stdCount,
      bool imageExist,
      ClassModel2 element) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ClassRoom(element: element)));
        },
        child: Container(
          decoration: boxDecoration(radius: 10, showShadow: true),
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
              children: <Widget>[
                Container(
                  width: w / 3,
                  height: w / 2.8,
                  decoration: imagePath.isEmpty
                      ? boxDecoration(
                          radius: 8,
                          showShadow: true,
                          imageExsit: true,
                          imagetype: 0,
                          boxfit: BoxFit.cover,
                          imageAsset: 'assets/images/class.png')
                      : boxDecoration(
                          radius: 8,
                          showShadow: true,
                          imageExsit: true,
                          imagetype: 1,
                          boxfit: BoxFit.cover,
                          imageUrl: personImagesPath + imagePath),
                ),
                Container(
                  width: w - (w / 3) - 35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ClassRoom(element: element)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: green,
                                borderRadius: new BorderRadius.only(
                                    bottomRight: const Radius.circular(16.0),
                                    topRight: const Radius.circular(16.0)),
                              ),
                              padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                              child: text('فتح',
                                  textColor: white,
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
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            text(title,
                                textColor: color3,
                                fontSize: f * 1.2,
                                textaligntype: 2,
                                isBold: true),
                            SizedBox(height: 4),
                            text(instor, textaligntype: 2, fontSize: f),
                            SizedBox(height: 4),
                            text("عدد الطلاب: " + stdCount,
                                fontSize: f, textaligntype: 2, maxLine: 1),
                            SizedBox(height: 4),
                          ],
                        ),
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
  }

  dialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child:
                StatefulBuilder(builder: (context, StateSetter setDialogState) {
              return Container(
                height: h * 0.2,
                width: w * 0.7,
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: <Widget>[
                    Spacer(),
                    InkWell(
                      onTap: () async {
                        String ky = await scan();
                        if (ky != '-1') {
                          BlocProvider.of<SearchForClassBloc>(context)
                              .add(Search(ky: ky));
                          setState(() {
                            iswriting = false;
                          });
                          Navigator.pop(context);
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
                                    '',
                                    h,
                                    w,
                                    f,
                                  ));
                        }
                      },
                      child: Container(
                        height: h * 0.1,
                        width: h * 0.1,
                        decoration: boxDecoration(
                            imageExsit: true,
                            boxfit: BoxFit.contain,
                            imageAsset: 'assets/images/camera.png'),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () async {
                        var pfile = await ImagePicker.platform
                            .pickImage(source: ImageSource.gallery);
                        if (pfile != null) {
                          String? result = await Scan.parse(pfile.path);
                          if (result != '-1') {
                            BlocProvider.of<SearchForClassBloc>(context)
                                .add(Search(ky: result!));
                            setState(() {
                              iswriting = false;
                            });
                            Navigator.pop(context);
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
                                      '',
                                      h,
                                      w,
                                      f,
                                    ));
                          }
                        }
                      },
                      child: Container(
                        height: h * 0.09,
                        width: h * 0.1,
                        decoration: boxDecoration(
                            imageExsit: true,
                            boxfit: BoxFit.contain,
                            imageAsset: 'assets/images/gallery.png'),
                      ),
                    ),
                    Spacer()
                  ],
                ),
              );
            }),
          );
        });
  }

  linkToClassBtn() {
    return InkWell(
      onTap: () async {
        dialog();
        // String ky = await scan();
        // if (ky.isNotEmpty) {
        //   BlocProvider.of<SearchForClassBloc>(context).add(Search(ky: ky));
        //   setState(() {
        //     iswriting = false;
        //   });
        //   showModalBottomSheet(
        //       backgroundColor: white,
        //       isScrollControlled: true,
        //       barrierColor: Colors.transparent,
        //       shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.only(
        //               topLeft: Radius.circular(15),
        //               topRight: Radius.circular(15))),
        //       context: context,
        //       builder: (context) => buildSheets(
        //             '',
        //             h,
        //             w,
        //             f,
        //           ));
        // }
      },
      child: Container(
        height: h * 0.05,
        width: w * 0.8,
        margin: EdgeInsets.only(top: h * 0.02),
        decoration: boxDecoration(showShadow: true, color1: white),
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: text('فحص QRcode للإنضمام الى مقرر',
                  fontSize: f, fontSizesLevel: 0, textColor: blue),
            )),
      ),
    );
  }

  Padding searchField() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3))
          ],
        ),
        child: TextField(
          controller: searchcontroller,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            filled: true,
            fillColor: white,
            hintText: 'ابحث عن مقررك',
            border: InputBorder.none,
            prefixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print('it is pressed');
                if (searchcontroller.text.isNotEmpty) {
                  BlocProvider.of<SearchForClassBloc>(context)
                      .add(Search(ky: searchcontroller.text));
                  setState(() {
                    iswriting = false;
                  });
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
                            '',
                            h,
                            w,
                            f,
                          ));
                }
              },
            ),
            contentPadding:
                EdgeInsets.only(left: 50.0, bottom: 8.0, top: 8.0, right: 0.0),
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }

  Padding textFiled() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: w * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3))
          ],
        ),
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          controller: passcodecontroller,
          onSubmitted: (v) {
            setState(() {
              iswriting = false;
            });
          },
          onTap: () {
            setState(() {
              iswriting = true;
            });
          },
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: white,
            hintText: 'كود المقرر',
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(bottom: 8.0, top: 8.0),
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }

  Widget buildSheets(String title, double height, double width, double fontx) {
    bool showError = false;
    String errorString = '';
    return FractionallySizedBox(
        heightFactor: iswriting ? 0.8 : 0.4,
        child: StatefulBuilder(builder: (context, StateSetter setSheetState) {
          return BlocListener<LinkClassBloc, LinkClassState>(
            listener: (context, state) => {
              if (state is LinkClassDone)
                {
                  if (state.connection)
                    {
                      if (state.res)
                        {
                          BlocProvider.of<GetLinkedClassesBloc>(context)
                              .add(GetLinkedClasses()),
                          Navigator.pop(context)
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
            child: Container(
              decoration: boxDecoration(radius: 10),
              child: Column(
                children: [
                  Container(
                      height: h * 0.02,
                      width: w,
                      decoration: BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)))),
                  Container(
                    height: h * 0.36 - 4,
                    child: Row(
                      children: [
                        Container(
                          height: h * 0.36 - 4,
                          width: h * 0.02,
                          decoration: boxDecoration(bgColor: blue),
                        ),
                        BlocBuilder<SearchForClassBloc, SearchForClassState>(
                            builder: (context, state) {
                          if (state is LoadingState) {
                            return Container(
                              height: h * 0.36 - 4,
                              width: w - (((h * 0.02) * 2)) - 5,
                              child: Center(
                                child: Container(
                                  height: h * 0.03,
                                  width: h * 0.03,
                                  child: CircularProgressIndicator(
                                      color: blue, strokeWidth: 3),
                                ),
                              ),
                            );
                          }
                          // else if (state is SearchRes) {
                          //   if (state.connection) {
                          //     return Container(
                          //       height: h * 0.36 - 4,
                          //       width: w - (((h * 0.02) * 2)) - 5,
                          //       child: Column(
                          //         children: [
                          //           Spacer(),
                          //           text(state.data.name,
                          //               fontSize: f * 1.1,
                          //               fontSizesLevel: 1,
                          //               isBold: true,
                          //               textColor: blue),
                          //           Container(
                          //             height: h * 0.01,
                          //           ),
                          //           textFiled(),
                          //           InkWell(
                          //             onTap: () {
                          //               BlocProvider.of<LinkClassBloc>(context)
                          //                   .add(LinkClass(
                          //                       ky: state.data.ky,
                          //                       passcode:
                          //                           passcodecontroller.text));
                          //               // Navigator.of(context).push(
                          //               //     MaterialPageRoute(
                          //               //         builder: (BuildContext context) =>
                          //               //             ClassRoom()));
                          //             },
                          //             child: Container(
                          //               height: h * 0.07,
                          //               margin: EdgeInsets.only(
                          //                   left: w * 0.05, right: w * 0.05),
                          //               decoration: BoxDecoration(
                          //                 boxShadow: [
                          //                   BoxShadow(
                          //                       color: Colors.grey
                          //                           .withOpacity(0.2),
                          //                       spreadRadius: 5,
                          //                       blurRadius: 7,
                          //                       offset: Offset(0, 3))
                          //                 ],
                          //                 borderRadius:
                          //                     BorderRadius.circular(25),
                          //                 gradient: LinearGradient(
                          //                     begin: Alignment.topLeft,
                          //                     end: Alignment.bottomRight,
                          //                     colors: [
                          //                       blue,
                          //                       darkblue,
                          //                     ]),
                          //               ),
                          //               child: BlocBuilder<LinkClassBloc,
                          //                       LinkClassState>(
                          //                   builder: (context, state) {
                          //                 return state is LoadingStateForLinking
                          //                     ? Center(
                          //                         child: Container(
                          //                           height: h * 0.03,
                          //                           width: h * 0.03,
                          //                           child:
                          //                               CircularProgressIndicator(
                          //                             color: white,
                          //                             strokeWidth: 3,
                          //                           ),
                          //                         ),
                          //                       )
                          //                     : Center(
                          //                         child: Text("إنضمام",
                          //                             style: TextStyle(
                          //                                 fontSize: f,
                          //                                 fontWeight:
                          //                                     FontWeight.bold,
                          //                                 color: white)),
                          //                       );
                          //               }),
                          //             ),
                          //           ),
                          //           Container(height: h * 0.02),
                          //           showError
                          //               ? Container(
                          //                   child: Center(
                          //                     child: Text(errorString,
                          //                         style: TextStyle(
                          //                             color:
                          //                                 Colors.red.shade200,
                          //                             fontSize: f,
                          //                             fontWeight:
                          //                                 FontWeight.bold)),
                          //                   ),
                          //                 )
                          //               : Container(),
                          //           Spacer(),
                          //         ],
                          //       ),
                          //     );
                          //   } else {
                          //     return Container(
                          //       height: h * 0.36 - 4,
                          //       width: w - (((h * 0.02) * 2)) - 5,
                          //       decoration: boxDecoration(
                          //           imageExsit: true,
                          //           imageAsset: 'assets/images/noNet2.png',
                          //           boxfit: BoxFit.contain),
                          //     );
                          //   }
                          // }
                          else {
                            return Container();
                          }
                        }),
                        Container(
                          height: h * 0.36 - 4,
                          width: h * 0.02,
                          decoration: boxDecoration(bgColor: blue),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: h * 0.02,
                    width: w,
                    decoration: boxDecoration(bgColor: blue),
                  ),
                ],
              ),
            ),
          );
        }));
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
          )),
    );
  }

  Future scan() async {
    String barcodeScanRes = '';
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff4536", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = "";
    }
    return barcodeScanRes;
  }
}
