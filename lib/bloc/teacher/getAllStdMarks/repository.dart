import 'package:alwastia/bloc/teacher/getAllStdMarks/model.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:alwastia/bloc/teacher/getStudentsAttendance.dart/model.dart';
import 'dart:convert';
import 'dart:io';
import 'package:alwastia/consts.dart';

class GetAllStdMarksRepo {
  Future<List<MarksModel>> getMarks(
      String token, String classId) async {
    List<MarksModel> data = [];
    Uri url;
    url = Uri.parse(getAllStdMarksApi + "?classId=$classId");
    http.Response res = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    String s = await Utf8Decoder().convert(res.bodyBytes);
     print(res.statusCode);
    print(s);
    if (res.statusCode == 200) {
      var d = jsonDecode(s)['data'];
      for (var i = 0; i < d.length; i++) {
        data.add(MarksModel.fromJson(d[i]));
      }
    }
    return data;
  }
}
