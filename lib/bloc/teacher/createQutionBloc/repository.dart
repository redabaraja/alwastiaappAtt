import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:alwastia/consts.dart';

class CreateQutionRepo {
  Future<bool> createQuestion(
      String qution, String answer, String lectureid, String token) async {
    Uri url;
    url = Uri.parse(createQutionApi);
    http.Response res = await http.post(url, body: {
      "Name": qution,
      "LectureID": lectureid,
      "detail": answer,
      "Tiktok": token
    });
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    return res.statusCode == 200;
  }
}
