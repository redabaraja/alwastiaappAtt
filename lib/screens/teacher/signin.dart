import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/teacher/signUpbloc/event.dart';
import 'package:alwastia/bloc/teacher/signUpbloc/state.dart';
import 'package:alwastia/bloc/teacher/signUpbloc/bloc.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/screens/mainPage.dart';
import 'package:alwastia/screens/teacher/login.dart';
import 'package:alwastia/widgets/boxdecoration.dart';

class TeacherSignUp extends StatefulWidget {
  const TeacherSignUp({Key? key}) : super(key: key);

  @override
  State<TeacherSignUp> createState() => _TeacherSignUpState();
}

class _TeacherSignUpState extends State<TeacherSignUp> {
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var addresscontroller = TextEditingController();
  var degreecontroller = TextEditingController();
  bool isPasswordVisible = true;

  var usernamecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  bool showError = false;
  String errorString = '';
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double f = w / 25;
    return SafeArea(
      child: BlocListener<TSignUpBloc, TSignUpState>(
        listener: (context, state) => {
          if (state is Signed)
            {
              if (state.connection)
                {
                  if (state.res)
                    {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => MainPage(
                                isStd: false,
                              )))
                    }
                  else
                    {
                      setState(() {
                        showError = true;
                        errorString = "حصل خطاء ما";
                      })
                    }
                }
              else
                {
                  setState(() {
                    showError = true;
                    errorString = "لا يوجد إتصال بالانترنت";
                  })
                }
            }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: h * 0.03),
                    height: h * 0.15,
                    width: w,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: h * 0.15,
                        width: h * 0.15,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/logo.png'),
                                fit: BoxFit.contain),
                            borderRadius: BorderRadius.circular(100)),
                      ),
                    ),
                  ),
                  Container(
                    height: h * 0.12,
                    width: w,
                    margin: EdgeInsets.only(left: w * 0.1, right: w * 0.1),
                    child: Center(
                      child: Text(
                        'إنشاء حساب معلم',
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
                        // buildTextField(h, w, f, degreecontroller,
                        //     'الشهادة والتخصص', false),
                        buildTextField(h, w, f, usernamecontroller,
                            'البريد الإلكتروني', false),
                        buildTextField2(
                            h, w, f, passwordcontroller, 'كلمة المرور', true),
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
                        InkWell(
                          onTap: () {
                            if (valdiation()) {
                              BlocProvider.of<TSignUpBloc>(context).add(Signing(
                                  username: usernamecontroller.text,
                                  password: passwordcontroller.text,
                                  name: namecontroller.text,
                                  address: addresscontroller.text,
                                  number: phonecontroller.text));
                            }
                          },
                          child: Container(
                            height: h * 0.07,
                            margin: EdgeInsets.only(
                                left: w * 0.03, right: w * 0.03, top: h * 0.02),
                            decoration: BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.circular(15)),
                            child: BlocBuilder<TSignUpBloc, TSignUpState>(
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
                                      child: Text('إنشاء حساب',
                                          style: TextStyle(
                                              color: white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: f * 1.2)),
                                    );
                            }),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print("aaaaaaa");
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        TeacherLogin(isStd: false,)));
                          },
                          child: Container(
                            // height: h * 0.07,
                            margin: EdgeInsets.only(
                                left: w * 0.03, right: w * 0.03, top: h * 0.01),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text('تسجيل الدخول',
                                  style: TextStyle(
                                      color: blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: f * 0.9)),
                            ),
                          ),
                        ),
                        Container(
                          height: h * 0.003,
                        ),
                      ],
                    ),
                  ),
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

  Directionality buildTextField2(double height, double width, double fontx,
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
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                icon: isPasswordVisible
                    ? Icon(
                        Icons.visibility,
                        color: blue,
                      )
                    : Icon(
                        Icons.visibility_off,
                        color: color3,
                      )),
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
          obscureText: isPasswordVisible,
        ),
      ),
    );
  }

  valdiation() {
    bool res = true;
    if (usernamecontroller.text.isEmpty) {
      res = false;
      setState(() {
        showError = true;
        errorString = "فضلا ادخل البريد الإلكتروني";
      });
    } else if (passwordcontroller.text.isEmpty) {
      res = false;
      setState(() {
        showError = true;
        errorString = "فضلا ادخل كلمة المرور";
      });
    } else if (addresscontroller.text.isEmpty) {
      res = false;
      setState(() {
        showError = true;
        errorString = "فضلا ادخل  عنوانك";
      });
    } else if (phonecontroller.text.isEmpty) {
      res = false;
      setState(() {
        showError = true;
        errorString = "فضلا ادخل رقم جوالك";
      });
    } else if (namecontroller.text.isEmpty) {
      res = false;
      setState(() {
        showError = true;
        errorString = "فضلا ادخل اسمك";
      });
    }
    return res;
  }
}
