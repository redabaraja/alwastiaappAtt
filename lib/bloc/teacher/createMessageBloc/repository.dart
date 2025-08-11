import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:alwastia/consts.dart';

class CreateNotiRepo {
  Future<bool> createNoti(String name, String token, String classID,String detail) async {
    Uri url;
    url = Uri.parse(createNotiApi);
    http.Response res = await http.post(url, body: {
      "Name": name,
      "ClassID": classID,
      "detail": detail,
      "Tiktok": token
    });
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    return res.statusCode == 200;
  }
}
