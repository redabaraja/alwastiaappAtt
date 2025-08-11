import 'package:alwastia/bloc/student/getStdSemesters/model.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';
import 'dart:convert';
import 'dart:io';

import 'package:alwastia/consts.dart';

class GetStdSemestersRepo {
  

  Future<List<SemesterModel>> getSemesters(String token) async {
    List<SemesterModel> data = [];
    Uri url;
    url = Uri.parse(getStdSemestersApi);
    http.Response res = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    if (res.statusCode == 200) {
      var d = jsonDecode(s)['data'];
      for (var i = 0; i < d.length; i++) {
        data.add(SemesterModel.fromMap(d[i]));
      }
    }
    return data;
  }
}
