import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:alwastia/consts.dart';

class CreateClassRepo {
  Future<bool> createClass(String name, String descr, String token) async {
    Uri url;
    url = Uri.parse(createClassApi);
    http.Response res = await http.post(url, body: {
      "Name": name,
      "Descr": descr,
      "id": '',
      "Logo": '',
      "Tiktok": token
    });
    String s = await Utf8Decoder().convert(res.bodyBytes);
    // print(s);
    return res.statusCode == 200;
  }
  Future<bool> updateClass(String name, String descr, String token,String id) async {
    Uri url;
    url = Uri.parse(createClassApi);
    http.Response res = await http.post(url, body: {
      "Name": name,
      "Descr": descr,
      "id": id,
      "Logo": '',
      "Tiktok": token
    });
    String s = await Utf8Decoder().convert(res.bodyBytes);
    // print(s);
    return res.statusCode == 200;
  }
}
