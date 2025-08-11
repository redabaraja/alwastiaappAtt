import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:alwastia/bloc/teacher/getStudentsAttendance.dart/model.dart';
import 'dart:convert';
import 'dart:io';
import 'package:alwastia/consts.dart';

class GetClassStudentsAttendanceRepo {
  Future<List<StudentAttendanceModel>> getStudentsAttendance(
      String token, String lectureID, String classId) async {
    List<StudentAttendanceModel> data = [];
    Uri url;
    url = Uri.parse(attendanceApi + "?classId=$classId&atDate=$lectureID");
    http.Response res = await http.post(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    if (res.statusCode == 200) {
      var d = jsonDecode(s)['data'];
      for (var i = 0; i < d.length; i++) {
        data.add(StudentAttendanceModel.fromMap(d[i]));
      }
    }
    return data;
  }
}
