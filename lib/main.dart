import 'package:alwastia/bloc/student/LinkClassBloc/state.dart';
import 'package:alwastia/bloc/student/SearchForClassBloc/state.dart';
import 'package:alwastia/bloc/student/geLinkedClassesBloc/state.dart';
import 'package:alwastia/bloc/student/getStdMarks/bloc.dart';
import 'package:alwastia/bloc/student/getStdMarks/state.dart';
import 'package:alwastia/bloc/student/getStdSemesters/bloc.dart';
import 'package:alwastia/bloc/student/getStdSemesters/state.dart';
import 'package:alwastia/bloc/student/loginBloc/state.dart';
import 'package:alwastia/bloc/student/profileBloc/state.dart';
import 'package:alwastia/bloc/student/signUpbloc/state.dart';
import 'package:alwastia/bloc/student/updateUserInfoBloc/state.dart';
import 'package:alwastia/bloc/student/uploadhomeworkbloc/state.dart';
import 'package:alwastia/bloc/teacher/CloseClassBloc/state.dart';
import 'package:alwastia/bloc/teacher/CloseLectureBloc/state.dart';
import 'package:alwastia/bloc/teacher/CloseStudentInClass/state.dart';
import 'package:alwastia/bloc/teacher/StudentAttendanceBloc/state.dart';
import 'package:alwastia/bloc/teacher/classInfoBloc/state.dart';
import 'package:alwastia/bloc/teacher/createExamBloc/state.dart';
import 'package:alwastia/bloc/teacher/createFileBloc/state.dart';
import 'package:alwastia/bloc/teacher/createHomeWorkBloc/state.dart';
import 'package:alwastia/bloc/teacher/createMessageBloc/state.dart';
import 'package:alwastia/bloc/teacher/createQutionBloc/state.dart';
import 'package:alwastia/bloc/teacher/createclassBloc/state.dart';
import 'package:alwastia/bloc/teacher/createlectureBloc/state.dart';
import 'package:alwastia/bloc/teacher/getAllStdMarks/bloc.dart';
import 'package:alwastia/bloc/teacher/getAllStdMarks/state.dart';
import 'package:alwastia/bloc/teacher/getAttendanceSumery.dart/state.dart';
import 'package:alwastia/bloc/teacher/getAttendances/bloc.dart';
import 'package:alwastia/bloc/teacher/getAttendances/state.dart';
import 'package:alwastia/bloc/teacher/getHomeWorkStdBloc/state.dart';
import 'package:alwastia/bloc/teacher/getMyClassesBloc/state.dart';
import 'package:alwastia/bloc/teacher/getMyClosingClassesBloc/state.dart';
import 'package:alwastia/bloc/teacher/getMyExamsBloc/state.dart';
import 'package:alwastia/bloc/teacher/getMyFilesBloc/state.dart';
import 'package:alwastia/bloc/teacher/getMyLecturesBloc/state.dart';
import 'package:alwastia/bloc/teacher/getMyNotiBloc/state.dart';
import 'package:alwastia/bloc/teacher/getMyQuestionsBloc/state.dart';
import 'package:alwastia/bloc/teacher/getMyStudents.dart/state.dart';
import 'package:alwastia/bloc/teacher/getStudentsAttendance.dart/state.dart';
import 'package:alwastia/bloc/teacher/getStudentsMarks/bloc.dart';
import 'package:alwastia/bloc/teacher/getStudentsMarks/state.dart';
import 'package:alwastia/bloc/teacher/gethomeworks/state.dart';
import 'package:alwastia/bloc/teacher/gethomeworks2/state.dart';
import 'package:alwastia/bloc/teacher/saveAttendanceBloc/state.dart';
import 'package:alwastia/bloc/teacher/saveResultBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/saveResultBloc/state.dart';
import 'package:alwastia/bloc/teacher/signUpbloc/state.dart';
import 'package:alwastia/bloc/teacher/updateLectureBloc/state.dart';
import 'package:alwastia/bloc/teacher/updatePassCodeBloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:alwastia/bloc/student/LinkClassBloc/bloc.dart';
import 'package:alwastia/bloc/student/SearchForClassBloc/bloc.dart';
import 'package:alwastia/bloc/student/geLinkedClassesBloc/bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/bloc.dart';
import 'package:alwastia/bloc/student/profileBloc/bloc.dart';
import 'package:alwastia/bloc/student/signUpbloc/bloc.dart';
import 'package:alwastia/bloc/student/updateUserInfoBloc/bloc.dart';
import 'package:alwastia/bloc/student/uploadhomeworkbloc/bloc.dart';
import 'package:alwastia/bloc/teacher/CloseClassBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/CloseLectureBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/CloseStudentInClass/bloc.dart';
import 'package:alwastia/bloc/teacher/StudentAttendanceBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/classInfoBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/createExamBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/createFileBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/createHomeWorkBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/createMessageBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/createQutionBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/createclassBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/createlectureBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getAttendanceSumery.dart/bloc.dart';
import 'package:alwastia/bloc/teacher/getHomeWorkStdBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyClassesBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyClosingClassesBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyExamsBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyFilesBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyLecturesBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyNotiBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyQuestionsBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/getMyStudents.dart/bloc.dart';
import 'package:alwastia/bloc/teacher/getStudentsAttendance.dart/bloc.dart';
import 'package:alwastia/bloc/teacher/gethomeworks/bloc.dart';
import 'package:alwastia/bloc/teacher/gethomeworks2/bloc.dart';
import 'package:alwastia/bloc/teacher/saveAttendanceBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/signUpbloc/bloc.dart';
import 'package:alwastia/bloc/teacher/updateLectureBloc/bloc.dart';
import 'package:alwastia/bloc/teacher/updatePassCodeBloc/bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:alwastia/screens/splash.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (con) => LoginBloc(LoginState())),
        BlocProvider<ProFileBloc>(create: (con) => ProFileBloc(ProfileState())),
        BlocProvider<SignUpBloc>(create: (con) => SignUpBloc(SignUpState())),
        BlocProvider<UpdateUserInfoBloc>(
            create: (con) => UpdateUserInfoBloc(UpdateUserInfoState())),
        BlocProvider<SearchForClassBloc>(
            create: (con) => SearchForClassBloc(SearchForClassState())),
        BlocProvider<GetLinkedClassesBloc>(
            create: (con) => GetLinkedClassesBloc(GetLinkedClassesState())),
        BlocProvider<LinkClassBloc>(
            create: (con) => LinkClassBloc(LinkClassState())),

        //
        BlocProvider<TSignUpBloc>(create: (con) => TSignUpBloc(TSignUpState())),
        BlocProvider<UpdatePasscodeBloc>(
            create: (con) => UpdatePasscodeBloc(UpdatePassCodeState())),
        BlocProvider<CreateClassBloc>(
            create: (con) => CreateClassBloc(CreateClassState())),
        BlocProvider<CloseClassBloc>(
            create: (con) => CloseClassBloc(CloseClassState())),
        BlocProvider<CloseLectureBloc>(
            create: (con) => CloseLectureBloc(CloseLectureState())),
        BlocProvider<CloseStdBloc>(
            create: (con) => CloseStdBloc(CloseStdState())),
        BlocProvider<GetClassesBloc>(
            create: (con) => GetClassesBloc(GetClassesState())),
        BlocProvider<GetClosingClassesBloc>(
            create: (con) => GetClosingClassesBloc(GetClassesState2())),
        BlocProvider<CreateLectureBloc>(
            create: (con) => CreateLectureBloc(CreateLectureState())),
        BlocProvider<GetLecturesBloc>(
            create: (con) => GetLecturesBloc(GetLecturesState())),
        BlocProvider<CreateNotiBloc>(
            create: (con) => CreateNotiBloc(CreateNotiState())),
        BlocProvider<GetNotiBloc>(
            create: (con) => GetNotiBloc(GetNotisState())),
        BlocProvider<ClassInfoBloc>(
            create: (con) => ClassInfoBloc(CLassInfoState())),
        BlocProvider<CreateQuestionBloc>(
            create: (con) => CreateQuestionBloc(CreateQuestionState())),
        BlocProvider<GetQuestionBloc>(
            create: (con) => GetQuestionBloc(GetQuestionsState())),
        BlocProvider<CreateFileBloc>(
            create: (con) => CreateFileBloc(CreateFileState())),
        BlocProvider<GetFilesBloc>(
            create: (con) => GetFilesBloc(GetFilesState())),
        BlocProvider<UpdateLectureBloc>(
            create: (con) => UpdateLectureBloc(UpdateLectureState())),
        BlocProvider<CreateExamBloc>(
            create: (con) => CreateExamBloc(CreateExamState())),
        BlocProvider<GetExamsBloc>(
            create: (con) => GetExamsBloc(GetExamState())),
        BlocProvider<SaveAttendanceBloc>(
            create: (con) => SaveAttendanceBloc(SaveAttendanceState())),
        BlocProvider<AttendanceSummeryBloc>(
            create: (con) => AttendanceSummeryBloc(AttendanceSummeryState())),
        BlocProvider<GetClassStudentsAttendanceBloc>(
            create: (con) => GetClassStudentsAttendanceBloc(
                GetClassStudentsAttendanceState())),
        BlocProvider<GetClassStudentsBloc>(
            create: (con) => GetClassStudentsBloc(GetClassStudentsState())),
        BlocProvider<OneStudentAttendanceBloc>(
            create: (con) =>
                OneStudentAttendanceBloc(OneStudentAttendanceState())),
        BlocProvider<GetHomeWorkBloc>(
            create: (con) => GetHomeWorkBloc(GetHomeWorkState())),
        BlocProvider<GetHomeWorkBloc2>(
            create: (con) => GetHomeWorkBloc2(GetHomeWorkState2())),
        BlocProvider<CreateHomeWorkBloc>(
            create: (con) => CreateHomeWorkBloc(CreateHomeWorkState())),
        BlocProvider<GetHomeWorkStudentsBloc>(
            create: (con) =>
                GetHomeWorkStudentsBloc(GetHomeWorkStudentsState())),
        BlocProvider<UploadHomeWorkBloc>(
            create: (con) => UploadHomeWorkBloc(UploadHomeWorkState())),
        BlocProvider<GetAttendanceDatesBloc>(
            create: (con) => GetAttendanceDatesBloc(GetAttendanceDatesState())),
        BlocProvider<GetMarksBloc>(
            create: (con) => GetMarksBloc(GetMarksState())),
        BlocProvider<SaveResultBloc>(
            create: (con) => SaveResultBloc(SaveResultState())),
        BlocProvider<GetStdMarksBloc>(
            create: (con) => GetStdMarksBloc(GetStdMarksState())),
        BlocProvider<GetStdSemestersBloc>(
            create: (con) => GetStdSemestersBloc(GetStdSemestersState())),
        BlocProvider<GetAllStdMarksBloc>(
            create: (con) => GetAllStdMarksBloc(GetAllStdMarksState()))
      ],
      child: MaterialApp(
          title: 'المعلم الجامعي',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "DroidArabicKufi",
            primarySwatch: Colors.blue,
          ),
          home: AppSplashScreen()),
    );
  }
}
