import 'package:async/async.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:alwastia/bloc/teacher/getMyStudents.dart/model.dart';
import 'dart:convert';

import 'package:alwastia/consts.dart';

class GetClassStudentsRepo {
  Future<List<StudentModel>> getStudents(String token, String classID) async {
    List<StudentModel> data = [];
    Uri url;
    url = Uri.parse(getClassStudnetsApi2 + '?id=$classID');
    http.Response res = await http.post(url, headers: {
      // HttpHeaders.contentTypeHeader: 'application/json',
      // HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    }, body: {
      'id': classID
    });
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    if (res.statusCode == 200) {
      var d = jsonDecode(s)['data'];
      for (var i = 0; i < d.length; i++) {
        data.add(StudentModel.fromMap(d[i]));
      }
    }
    return data;
  }
}
