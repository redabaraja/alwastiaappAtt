import 'package:alwastia/bloc/student/getStdMarks/model.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:alwastia/bloc/teacher/getStudentsAttendance.dart/model.dart';
import 'dart:convert';
import 'dart:io';
import 'package:alwastia/consts.dart';

class GetMarksRepo {
  Future<List<MarksModelMain>> getMarks(String token) async {
    List<MarksModelMain> data = [];
    Uri url;
    url = Uri.parse(getStdMarksApi);
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
      for (var element in d) {
        data.add(MarksModelMain.fromJson(element));
      }
    }
    return data;
  }
}
