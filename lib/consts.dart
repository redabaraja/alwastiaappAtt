import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

const color1 = Color(0xff079cff);
const color2 = Color(0xffFEFBF3);
const color3 = Color(0xff000000);
const gray2 = Color(0xffcccccc);
const gray = Color(0xfff5f8fb);
const white = Color(0xffffffff);
const bink = Color(0xfffb7070);
const lightBlue = Color(0xffc4dbef);
const yellow = Color(0xffdcb920);
const green2 = Color(0xff04dfcc);
// const green = Color(0xff5e9e09);
const green = Color(0xff187bc6);
const adsColor = Color(0xffC4DBEF);
const lightgrey = Color(0xfffdfdfd);
const darkblue = Color(0xff3383ff);
const websiteBlue = Color(0xff0b5091);
const splashColor = Color(0xffFFFDF1);
const inputColor = Color(0xffF6F6F6);
// const blue = Color(0xff187bc6);
const blue = Color(0xff0b6f40);
const gradient = Color(0x333003ff);

double h = 0;
double w = 0;
double f = 0;
const qutionmark = '؟';
String teacherRId = '086d04a1-5845-4953-a30a-7275f2f27db4';
String toke = '';

// alwstia api

// const baseUrl3 = 'http://maidroos415419-001-site10.dtempurl.com';
String mail = '@sa.wasatia.edu.ye';
const baseUrl3 = 'http://sa.wasatia.edu.ye';
String getTeacherClassesApi2 = '$baseUrl3/api/SemesterClass/GetTeacherClasses';
String getClassStudnetsApi2 = '$baseUrl3/api/SemesterClass/getStudentInClass';
String userInfoApi2 = '$baseUrl3/api/Account/GetUserInfo/';
String updatePasswordApi = '$baseUrl3/api/Account/ResetPassword/';
String uploadClassImageApi2 = "$baseUrl3/api/SemesterClass/setImage";


String attendanceDatesApi =
    '$baseUrl3/api/TeacherAttendance/GetClassAttendanceDates';
String attendanceApi = '$baseUrl3/api/TeacherAttendance/GetClassAttendance';
String getMarksApi = '$baseUrl3/api/Result/GetStudentResult';
String getAllStdMarksApi = '$baseUrl3/api/StudentExams/TheoryWork';


String saveAttendanceApi2 =
    '$baseUrl3/api/TeacherAttendance/SaveClassAttendance';
String saveResultApi2 = '$baseUrl3/api/StudentExams/SaveResult';
String getClassAttendanceSummeryApi2 =
    "$baseUrl3/api/TeacherAttendance/GetClassAttendanceSummury";
String authApi2 = "$baseUrl3/api/Auth/";

String getLinkedClassesApi2 = '$baseUrl3/api/SemesterClass/GetStudentClasses';
String getStdSemestersApi = '$baseUrl3/api/Result/GetStudentSemester';

String getStdMarksApi = '$baseUrl3/api/StudentExams/StudentTheoryWork';
String getStdAttendanceSummeryApi2 =
    "$baseUrl3/api/StudentAttendance/GetStudentClassAttendanceSummury";
String getStdAttendanceDetailsApi2 =
    "$baseUrl3/api/StudentAttendance/GetAttendancByStudent";

// original version api
const baseUrl =
    'http://register.syncc.edu.ye.100-42-49-69.ws134.avxwin.temp.domains';
// student apis
const authApi =
    "http://register.syncc.edu.ye.100-42-49-69.ws134.avxwin.temp.domains/RestAPI/GetUserToken";
const signUpApi =
    "http://register.syncc.edu.ye.100-42-49-69.ws134.avxwin.temp.domains/apiService/User/RegisteUser";
const userInfoApi =
    "http://register.syncc.edu.ye.100-42-49-69.ws134.avxwin.temp.domains/apiService/User/getUserInfo";
const updateuserImageApi =
    "http://register.syncc.edu.ye.100-42-49-69.ws134.avxwin.temp.domains/apiService/User/UpdateUserPhoto";
const updateuserInfoApi =
    "http://register.syncc.edu.ye.100-42-49-69.ws134.avxwin.temp.domains/apiService/User/UpdateUserInfo";
String searchForClassApi = '$baseUrl/apiService/class/GetDetails';
String getLinkedClassesApi = '$baseUrl/apiService/Student/ListClasses';
String linkclassApi = '$baseUrl/apiService/class/StudentJoin';

// const baseUrl = "http://register.syncc.edu.ye.100-42-49-69.ws134.avxwin.temp.domains/";
// const newsImagesPath = "http://smaj.seiyunu.edu.ye/Uploads/ImgFiles/";
const personImagesPath =
    "http://register.syncc.edu.ye.100-42-49-69.ws134.avxwin.temp.domains/Files/img/";
const personImagesPath2 =
    "http://maidroos415419-001-site10.dtempurl.com/uploads/";
const filesPath =
    "http://register.syncc.edu.ye.100-42-49-69.ws134.avxwin.temp.domains/Files/attachements/";

//teacher apis
String createClassApi = '$baseUrl/apiService/class/CreateOrUpdate';
String closeClassApi = '$baseUrl/apiService/class/UpdateStatus';
String createLectureApi = '$baseUrl/apiService/Lecture/CreateOrUpdate';
String createExamApi = '$baseUrl/apiService/Marks/CreateOrUpdateExam';
String getTeacherClassesApi = '$baseUrl/apiService/class/ListAll';
String getLecturesApi = '$baseUrl/apiService/Lecture/ListAll';
String getExamsApi = '$baseUrl/apiService/Marks/ListAll';
String closeLectureApi = '$baseUrl/apiService/Lecture/UpdateStatus';
String closeStdApi = '$baseUrl/apiService/class/UpdateStudentInClassStatus';
String createNotiApi = '$baseUrl/apiService/Notify/CreateOrUpdate';
String getNotiApi = '$baseUrl/apiService/Notify/ListAll';
String uploadClassImageApi = "$baseUrl/apiService/Class/UploadLogo";
String getCLassStudnetsApi = "$baseUrl/apiService/Class/StudentsInClass";
String updatePassCodeApi = "$baseUrl/apiService/class/UpdatePassCode";
String getLectureStudnetsAttendanceApi =
    "$baseUrl/apiService/Lecture/ListAttendance";
String getClassAttendanceSummeryApi =
    "$baseUrl/apiService/Lecture/AttendanceSummary";
String getOneStudentAttendanceApi =
    "$baseUrl/apiService/Student/StudentAttendanceSummary";
String saveAttendanceApi = '$baseUrl/apiService/Lecture/SaveAttendance';

String createQutionApi = '$baseUrl/apiService/Question/CreateOrUpdate';
String getQuestionApi = '$baseUrl/apiService/Question/ListAll';
String uploadFileApi = "$baseUrl/apiService/Attachment/CreateOrUpdate";
String uploadStdHomeWorkApi =
    "$baseUrl/apiService/AssignmentDetail/CreateOrUpdate";
String getFilesApi = '$baseUrl//apiService/Attachment/ListAll';
String getHomeWorkApi = '$baseUrl/apiService/Assignment/ListAll';
String getHomeWorkForStdApi = '$baseUrl/apiService/Assignment/ListForStudent';
String createHomeWorkApi = '$baseUrl/apiService/Assignment/CreateOrUpdate';
String getHomeWorkStdApi = '$baseUrl/AssignmentDetail/ListAll';

Future<bool> hasNetwork() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

initlengthAndWith(BuildContext context) {
  h = MediaQuery.of(context).size.height;
  w = MediaQuery.of(context).size.width;
  f = w / 25;
}

Container appBar(
  double height,
  double width,
  GlobalKey<ScaffoldState> scaffoldKey,
  BuildContext context,
  // WebState state
) {
  double fontx = width / 25;
  return Container(
    // margin: EdgeInsets.only(top: height * 0.06),
    height: height * 0.08,
    color: blue,
    child: Row(
      children: <Widget>[
        Container(
          width: width * 0.03,
        ),
        InkWell(
          onTap: () {
            scaffoldKey.currentState?.openDrawer();
          },
          child: Container(
            width: width * 0.1,
          ),
        ),
        const Spacer(),
        Container(
          height: height * 0.08,
          width: width * 0.4,
          margin: EdgeInsets.only(top: height * 0.01, bottom: height * 0.01),
          child: Center(
            child: AutoSizeText(
              'منصة التعليم الإلكتروني',
              presetFontSizes: [f * 1.2, f, f - f * 0.2, f - f * 0.4],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: white,
                fontFamily: 'DroidArabicKufi',
                fontSize: f * 1.4,
              ),
            ),
          ),
        ),
        Spacer(),
        InkWell(
            onTap: () {},
            child: Container(
              width: width * 0.1,
            ))
      ],
    ),
  );
}
