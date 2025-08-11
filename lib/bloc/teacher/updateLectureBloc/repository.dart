import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:alwastia/consts.dart';

class UpdateLectureRepo {
  Future<bool> updatelecture(String name, String descr, String token, String id,
      String classid) async {
    Uri url;
    url = Uri.parse(createLectureApi);
    http.Response res = await http.post(url, body: {
      "Name": name,
      "ClassID": classid,
      "Descr": descr,
      "Tiktok": token,
      "id": id
    });
    String s = await Utf8Decoder().convert(res.bodyBytes);
    // print(s);
    return res.statusCode == 200;
  }
}
