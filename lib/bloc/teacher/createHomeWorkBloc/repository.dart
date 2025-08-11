import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:alwastia/consts.dart';

class CreateHomeWorkRepo {
  Future<bool> createHomeWork(
      String name, String desc, String classid,String date, String token) async {
    Uri url;
    url = Uri.parse(createHomeWorkApi);
    http.Response res = await http.post(url, body: {
      "Name": name,
      "classID": classid,
      "Descr": desc,
      "Tiktok": token,
      "DueDate":date
    });
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    return res.statusCode == 200;
  }
}
