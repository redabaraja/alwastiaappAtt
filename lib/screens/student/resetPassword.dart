import 'package:alwastia/widgets/text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/event.dart';
import 'package:alwastia/bloc/student/loginBloc/state.dart';
import 'package:alwastia/consts.dart';
import 'package:flutter/material.dart';
import 'package:alwastia/screens/mainPage.dart';
import 'package:alwastia/screens/student/signin.dart';
import 'package:alwastia/widgets/boxdecoration.dart';

class ResetPassword extends StatefulWidget {
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  var usernamecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var newpasswordcontroller = TextEditingController();
  var newpasswordcontroller1 = TextEditingController();
  bool isPasswordVisible = true;
  bool isPasswordVisible1 = true;
  bool isPasswordVisible2 = true;
  bool showError = false;
  String errorString = '';
  showErrorDialog(BuildContext context, String errorMessage, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: white,
          child: Container(
            height: h * 0.2,
            width: w * 0.7,
            decoration: boxDecoration(radius: 15),
            child: Column(
              children: [
                Spacer(),
                text(errorMessage,
                    fontSize: f,
                    fontSizesLevel: 1,
                    isBold: true,
                    textColor: color),
                Spacer(),
                TextButton(
                  child: Text(
                    'موافق',
                    style: TextStyle(color: blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Container(
                  height: 10,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double f = w / 25;
    return SafeArea(
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) => {
          if (state is UpdatePassWordDone)
            {
              if (state.res)
                {print('it is true'), showErrorDialog(context, state.txt, blue)}
              else
                {
                  print('it is false'),
                  showErrorDialog(context, 'حصل خطا ما', blue)
                }
            }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: h * 0.1),
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
                        'تغيير كلمة المرور',
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        // buildTextField(h, w, f, usernamecontroller,
                        //     'البريد الإلكتروني', false),
                        buildTextField2(h, w, f, passwordcontroller,
                            'كلمة المرور', true, 0),
                        buildTextField2(h, w, f, newpasswordcontroller,
                            'كلمة المرور الجديدة', true, 1),
                        buildTextField2(h, w, f, newpasswordcontroller1,
                            'إعادة كلمة المرور الجديدة', true, 2),
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
                        BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                          return Material(
                            child: InkWell(
                              splashColor: white,
                              onTap: () {
                                if (valdiation()) {
                                  BlocProvider.of<LoginBloc>(context)
                                      .add(UpdatePassWord(
                                    newPassword: newpasswordcontroller.text,
                                    oldPassword: passwordcontroller.text,
                                  ));
                                }
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
                                child: state is LoadingState
                                    ? Center(
                                        child: Container(
                                          height: h * 0.035,
                                          width: h * 0.035,
                                          child: CircularProgressIndicator(
                                            color: white,
                                            strokeWidth: 3,
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: Text('تغيير كلمة المرور',
                                            style: TextStyle(
                                                color: white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: f * 1.2)),
                                      ),
                              ),
                            ),
                          );
                        }),
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

  Directionality buildTextField2(double height, double width, double fontx,
      TextEditingController controller, String hint, bool secureWords, int n) {
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
                    n == 0
                        ? isPasswordVisible = !isPasswordVisible
                        : n == 1
                            ? isPasswordVisible1 = !isPasswordVisible1
                            : isPasswordVisible2 = !isPasswordVisible2;
                  });
                },
                icon: n == 0
                    ? isPasswordVisible
                        ? Icon(
                            Icons.visibility,
                            color: blue,
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: color3,
                          )
                    : n == 1
                        ? isPasswordVisible1
                            ? Icon(
                                Icons.visibility,
                                color: blue,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: color3,
                              )
                        : isPasswordVisible2
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
          obscureText: n == 0
              ? isPasswordVisible
              : n == 1
                  ? isPasswordVisible1
                  : isPasswordVisible2,
        ),
      ),
    );
  }

  valdiation() {
    bool res = true;
    if (passwordcontroller.text.isEmpty) {
      res = false;
      setState(() {
        showError = true;
        errorString = "فضلا ادخل كلمة المرور";
      });
    } else if (newpasswordcontroller.text.isEmpty) {
      res = false;
      setState(() {
        showError = true;
        errorString = "فضلا ادخل كلمة المرور الجديدة";
      });
    } else if (newpasswordcontroller.text.length<6) {
      res = false;
      setState(() {
        showError = true;
        errorString = 'كلمة المرور قصيرة جدا';
      });
    } else if (newpasswordcontroller1.text != newpasswordcontroller.text) {
      res = false;
      setState(() {
        showError = true;
        errorString = 'اعادة كتابة كلمة المرور غير صحيح';
      });
    }
    return res;
  }
}
