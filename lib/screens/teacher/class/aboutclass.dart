import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/teacher/CloseClassBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/CloseClassBloc/state.dart';
import 'package:alwastia/bloc/teacher/getMyClassesBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyClassesBloc/event.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:alwastia/bloc/teacher/getMyClassesBloc/model.dart';
import 'package:alwastia/bloc/teacher/getMyClosingClassesBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyClosingClassesBloc/event.dart';
import 'package:alwastia/bloc/teacher/updatePassCodeBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/updatePassCodeBloc/state.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/widgets/boxdecoration.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class AboutClass extends StatefulWidget {
  late ClassModel element;
  late bool isCLosing;
  AboutClass({required this.element, required this.isCLosing});
  @override
  State<AboutClass> createState() =>
      _AboutClassState(element: element, isClosing: isCLosing);
}

class _AboutClassState extends State<AboutClass>
    with AutomaticKeepAliveClientMixin {
  late ClassModel element;
  late bool isClosing;
  _AboutClassState({required this.element, required this.isClosing});
  var passcodecontroller = TextEditingController();
  bool iswriting = false;
  ScreenshotController screenShotController = ScreenshotController();
  bool showError = false;
  String errorString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CloseClassBloc, CloseClassState>(
        listener: (context, state) => {
          if (state is CloseState)
            {
              if (state.connection)
                {
                  if (state.res)
                    {
                      BlocProvider.of<GetClassesBloc>(context)
                          .add(GetMyClasses(status: '0')),
                      BlocProvider.of<GetClosingClassesBloc>(context)
                          .add(GetMyClosingClasses(status: '-1')),
                      setState(() {
                        showError = true;
                        isClosing
                            ? errorString = 'تم تفعيل المقرر بنجاح'
                            : errorString = 'تم إغلاق المقرر بنجاح';
                      })
                    }
                  else
                    {
                      setState(() {
                        showError = true;
                        errorString = 'حصل خطاء ما';
                      })
                    }
                }
              else
                {
                  setState(() {
                    showError = true;
                    errorString = 'لا يوجد إتصال بالانترنت';
                  })
                }
            }
        },
        child: Container(
          margin: EdgeInsets.only(left: 16, top: 20, right: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                infoline("اسم المقرر", element.name),
                Container(
                  height: h * 0.03,
                ),
                infoline("المستوى", element.level),
                Container(
                  height: h * 0.03,
                ),
                infoline("التخصص", element.major),
                spaceBetweenBtns(),
                // infoline("عدد الطلاب", element.stdCount.toString()),
                spaceBetweenBtns(),
                // InkWell(
                //     onTap: () {
                //       Clipboard.setData(ClipboardData(text: ''));
                //     },
                //     child: infoline(
                //         "كود الإنظمام",
                //         element.passCode == null
                //             ? ''
                //             : element.passCode.toString())),
                spaceBetweenBtns(),
                // infoline("الوصف", element.descr),
                Container(
                  height: h * 0.03,
                ),
                // Container(
                //   width: w,
                //   child: InkWell(
                //     onTap: () async {
                //       final image = await screenShotController.capture();
                //       if (image == null) return;
                //       await shareImage(image);
                //     },
                //     child: Center(
                //       child: text('مشاركة المقرر',
                //           fontSize: f,
                //           fontSizesLevel: 1,
                //           isBold: true,
                //           textColor: blue),
                //     ),
                //   ),
                // ),
                // Screenshot(
                //   controller: screenShotController,
                //   child: Container(
                //     height: h * 0.2,
                //     width: w * 0.5,
                //     margin: EdgeInsets.only(top: h * 0.03),
                //     padding: EdgeInsets.all(h * 0.01),
                //     decoration: BoxDecoration(
                //       color: white,
                //       borderRadius: BorderRadius.circular(10),
                //       border: Border.all(color: white, width: 1),
                //       boxShadow: [
                //         BoxShadow(
                //             color: Colors.grey.withOpacity(0.2),
                //             spreadRadius: 5,
                //             blurRadius: 7,
                //             offset: Offset(0, 3))
                //       ],
                //     ),
                //     child: BarcodeWidget(
                //       barcode: Barcode.qrCode(),
                //       data: element.ky,
                //     ),
                //   ),
                // ),

                // Container(
                //   height: h * 0.05,
                // ),
                // InkWell(
                //     onTap: () {
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (BuildContext context) => UpdateClassInfo(
                //                 classDisc: element.descr,
                //                 className: element.name,
                //                 code: element.passCode == null
                //                     ? ''
                //                     : element.passCode,
                //                 id: element.id,
                //               )));
                //     },
                //     child: buttons('تعديل بيانات المقرر', 0, green, 0)),
                spaceBetweenBtns(),
                // InkWell(
                //     onTap: () {
                //       setState(() {
                //         iswriting = false;
                //       });
                //       showModalBottomSheet(
                //           backgroundColor: white,
                //           isScrollControlled: true,
                //           barrierColor: Colors.transparent,
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.only(
                //                   topLeft: Radius.circular(15),
                //                   topRight: Radius.circular(15))),
                //           context: context,
                //           builder: (context) => buildSheets(
                //                 h,
                //                 w,
                //                 f,
                //               ));
                //     },
                //     child: buttons('تعديل  كود الإنظمام', 0, green, 0)),
                // spaceBetweenBtns(),
                // InkWell(
                //     onTap: () {
                //       isClosing
                //           ? BlocProvider.of<CloseClassBloc>(context)
                //               .add(ActivateClass(classId: element.id))
                //           : BlocProvider.of<CloseClassBloc>(context)
                //               .add(CloseClass(classId: element.id));
                //     },
                //     child: buttons(isClosing ? 'تفعيل المقرر' : 'إغلاق المقرر',
                //         0, Colors.red.shade300, 1)),
                // Container(height: h * 0.05),
                // showError
                //     ? Container(
                //         child: Center(
                //           child: Text(errorString,
                //               style: TextStyle(
                //                   color: Colors.red.shade200,
                //                   fontSize: f,
                //                   fontWeight: FontWeight.bold)),
                //         ),
                //       )
                //     : Container(),
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

  Material buttons(String txt, int click, Color color, int n) {
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
        child: BlocBuilder<CloseClassBloc, CloseClassState>(
            builder: (context, state) {
          return state is LoadingState2 && n == 1
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

  Material buttons2(String txt, int click, Color color, int n) {
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
        child: BlocBuilder<UpdatePasscodeBloc, UpdatePassCodeState>(
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

  // Widget buildSheets(double height, double width, double fontx) {
  //   // passcodecontroller.text.==null?'':element.passCode;
  //   bool showError = false;
  //   String errorString = '';
  //   return FractionallySizedBox(
  //     heightFactor: iswriting ? 0.7 : 0.4,
  //     child: StatefulBuilder(builder: (context, StateSetter setSheetState) {
  //       return BlocListener<UpdatePasscodeBloc, UpdatePassCodeState>(
  //         listener: (context, state) => {
  //           if (state is UpdatePassCodeDone)
  //             {
  //               if (state.connection)
  //                 {
  //                   if (state.res)
  //                     {
  //                       // BlocProvider.of<>(context)
  //                       //     .add(GetMyLectures(classId: element.id)),
  //                       setSheetState(() {
  //                         setState(() {
  //                           element.passCode = passcodecontroller.text;
  //                         });
  //                         passcodecontroller.clear();
  //                         showError = true;
  //                         errorString = 'تم تعديل كود الإنظمام بنجاح';
  //                       })
  //                     }
  //                   else
  //                     {
  //                       setSheetState(() {
  //                         showError = true;
  //                         errorString = 'حصل خطاء ما';
  //                       })
  //                     }
  //                 }
  //               else
  //                 {
  //                   setSheetState(() {
  //                     showError = true;
  //                     errorString = 'لا يوجد إتصال بالانترنت';
  //                   })
  //                 }
  //             }
  //         },
  //         child: Scaffold(
  //           body: Container(
  //             margin: EdgeInsets.only(top: 5),
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(25),
  //                     topRight: Radius.circular(25))),
  //             height: height * 0.6,
  //             child: SingleChildScrollView(
  //               child: Container(
  //                 margin: EdgeInsets.only(top: 3),
  //                 decoration: BoxDecoration(
  //                     color: white,
  //                     borderRadius: BorderRadius.only(
  //                         topLeft: Radius.circular(25),
  //                         topRight: Radius.circular(25))),
  //                 // height: height * 0.41,
  //                 child: Column(
  //                   children: [
  //                     Container(
  //                       height: h * 0.05,
  //                     ),
  //                     Container(
  //                       child: text('كود الإنظمام',
  //                           fontSize: f,
  //                           textColor: green,
  //                           isBold: true,
  //                           fontSizesLevel: 1),
  //                     ),
  //                     buildTextField(
  //                         h, w, f, passcodecontroller, 'كود الإنظمام', false),
  //                     showError ? Container(height: h * 0.05) : Container(),
  //                     showError
  //                         ? Container(
  //                             child: Center(
  //                               child: Text(errorString,
  //                                   style: TextStyle(
  //                                       color: Colors.red.shade200,
  //                                       fontSize: f,
  //                                       fontWeight: FontWeight.bold)),
  //                             ),
  //                           )
  //                         : Container(),
  //                     Container(
  //                       height: h * 0.02,
  //                     ),
  //                     InkWell(
  //                         onTap: () {
  //                           print('sss');
  //                           if (passcodecontroller.text.isEmpty) {
  //                             setSheetState(() {
  //                               showError = true;
  //                               errorString = "فضلا ادخل كود الإنظمام  ";
  //                             });
  //                           } else
  //                             BlocProvider.of<UpdatePasscodeBloc>(context)
  //                                 .add(UpdatePassCode(
  //                               passCode: passcodecontroller.text,
  //                               classId: element.id,
  //                             ));
  //                         },
  //                         child: buttons2('تعديل', 0, green, 0)),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     }),
  //   );
  // }

  Directionality buildTextField(double height, double width, double fontx,
      TextEditingController controller, String hint, bool secureWords) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: height * 0.07,
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.only(
            left: width * 0.03, right: width * 0.03, top: height * 0.01),
        decoration: boxDecoration(radius: 15, color: blue),
        child: TextField(
          controller: controller,
          maxLines: 1,
          minLines: 1,
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
          textAlign: TextAlign.right,
          style: TextStyle(
              color: color3,
              fontFamily: 'DroidArabicKufi',
              fontSize: fontx - fontx * 0.1,
              fontWeight: FontWeight.bold),
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
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

  shareImage(Uint8List image) async {
    Directory dir = await getApplicationDocumentsDirectory();
    final img = File(dir.path + "/share.png");
    img.writeAsBytesSync(image);
    await Share.shareFiles([img.path]);
  }

  @override
  bool get wantKeepAlive => true;
}
