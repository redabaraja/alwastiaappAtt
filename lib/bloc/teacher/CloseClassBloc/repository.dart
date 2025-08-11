import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:alwastia/consts.dart';

class CloseClassRepo {
  closeCLass(String token, String classID) async {
    Uri url;
    url = Uri.parse(closeClassApi);
    http.Response res = await http
        .post(url, body: {"Tiktok": token, "Id": classID, "status": '-1'});
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    if (res.statusCode == 200) {
      var status = jsonDecode(s)['status'];
      return status == '1';
    }
    return false;
  }

  activateCLass(String token, String classID) async {
    Uri url;
    url = Uri.parse(closeClassApi);
    http.Response res = await http
        .post(url, body: {"Tiktok": token, "Id": classID, "status": '0'});
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    if (res.statusCode == 200) {
      var status = jsonDecode(s)['status'];
      return status == '1';
    }
    return false;
  }
}
