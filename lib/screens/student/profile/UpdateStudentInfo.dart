import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/profileBloc/model.dart';
import 'package:alwastia/bloc/student/updateUserInfoBloc/bloc.dart';
import 'package:alwastia/bloc/student/updateUserInfoBloc/event.dart';
import 'package:alwastia/bloc/student/updateUserInfoBloc/state.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/widgets/boxdecoration.dart';

class UpdateStudentInfo extends StatefulWidget {
  late UserModel data;
  UpdateStudentInfo({required this.data});
  @override
  State<UpdateStudentInfo> createState() => _UpdateStudentInfoState(data: data);
}

class _UpdateStudentInfoState extends State<UpdateStudentInfo> {
  late UserModel data;
  _UpdateStudentInfoState({required this.data});
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var addresscontroller = TextEditingController();
  String hidenText = '';
  Color hidenColor = color3;
  bool showHiden = false;
  var usernamecontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    namecontroller.text = data.name;
    phonecontroller.text = data.number;
    addresscontroller.text = data.adress;
    usernamecontroller.text = data.email;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double f = w / 25;
    return BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
      listener: (context, state) => {
        if (state is UpdateState)
          {
            if (state.connection)
              {
                if (state.res)
                  setState(() {
                    showHiden = true;
                    hidenText = "تم تعديل معلومات المستخدم بنجاح";
                    hidenColor = green;
                  })
                else
                  setState(() {
                    showHiden = true;
                    hidenText = "حصل خطاء ما";
                    hidenColor = Colors.red.shade400;
                  })
              }
            else
              {
                setState(() {
                  showHiden = true;
                  hidenText = "لا يوجد إتصال بالإنترنت";
                  hidenColor = Colors.red.shade400;
                })
              }
          }
      },
    
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: h * 0.03),
                    height: h * 0.03,
                    width: w,
                  ),
                  Container(
                    height: h * 0.12,
                    width: w,
                    margin: EdgeInsets.only(left: w * 0.1, right: w * 0.1),
                    child: Center(
                      child: Text(
                        'تعديل معلومات الحساب',
                        style: TextStyle(
                            color: color3,
                            fontSize: f * 1.2,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    height: h * 0.63,
                    margin: EdgeInsets.only(
                      left: w * 0.02,
                      right: w * 0.02,
                    ),
                    decoration: BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(
                      //       color:green.withOpacity(0.5),
                      //       spreadRadius: 5,
                      //       blurRadius: 7,
                      //       offset: Offset(0, 3))
                      // ],
                      // color: green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        buildTextField(
                            h, w, f, namecontroller, 'الاسم الرباعي', false),
                        buildTextField(
                            h, w, f, phonecontroller, 'رقم الجوال', false),
                        buildTextField(
                            h, w, f, addresscontroller, 'العنوان', false),
                        buildTextField(
                            h, w, f, usernamecontroller, 'اسم المستخدم', false),
                        InkWell(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (BuildContext context) => Profile()));
                          },
                          child: Material(
                            child: InkWell(
                              splashColor: white,
                              onTap: () {
                                BlocProvider.of<UpdateUserInfoBloc>(context)
                                    .add(UpdateData(
                                        phone: phonecontroller.text,
                                        email: usernamecontroller.text,
                                        name: namecontroller.text,
                                        city: '',
                                        address: addresscontroller.text));
                              },
                              child: Container(
                                height: h * 0.07,
                                margin: EdgeInsets.only(
                                    left: w * 0.03,
                                    right: w * 0.03,
                                    top: h * 0.02),
                                decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(15)),
                                child: BlocBuilder<UpdateUserInfoBloc,
                                        UpdateUserInfoState>(
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
                                          child: Text('تعديل',
                                              style: TextStyle(
                                                  color: white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: f * 1.2)),
                                        );
                                }),
                              
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: h * 0.03,
                        ),
                        showHiden
                            ? Container(
                                height: h * 0.07,
                                width: w,
                                child: Center(
                                  child: Text(hidenText,
                                      style: TextStyle(
                                          color: hidenColor,
                                          fontSize: f * 1.2)),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  )
                ],
              ),
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
        decoration: boxDecoration(radius: 15, color: green),
        child: TextField(
          controller: controller,
          maxLines: 1,
          minLines: 1,
          textAlign: TextAlign.center,
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
}
