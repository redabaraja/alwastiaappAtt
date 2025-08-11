import 'package:alwastia/bloc/teacher/getStudentsMarks/model.dart';
import 'package:alwastia/bloc/teacher/getStudentsMarks/model2.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:alwastia/bloc/teacher/getStudentsAttendance.dart/model.dart';
import 'dart:convert';
import 'dart:io';
import 'package:alwastia/consts.dart';

class GetMarksRepo {
  Future<ResultModel?> getMarks(String token, String semesterId) async {
    ResultModel? data;
    Uri url;
    url = Uri.parse(getMarksApi + "?semId=$semesterId");
    http.Response res = await http.post(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(res.statusCode);
    print(s);
    if (res.statusCode == 200) {
      var d = jsonDecode(s);
      data = ResultModel.fromJson(d);
    }
    return data;
  }
}
