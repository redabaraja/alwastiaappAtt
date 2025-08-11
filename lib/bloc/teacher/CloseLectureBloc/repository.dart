import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:alwastia/consts.dart';

class CloseLectureRepo {
  closeLecture(String token, String lectureID) async {
    Uri url;
    url = Uri.parse(closeLectureApi);
    http.Response res = await http
        .post(url, body: {"Tiktok": token, "Id": lectureID, "status": '-1'});
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    if (res.statusCode == 200) {
      var status = jsonDecode(s)['status'];
      return status == '1';
    }
    return false;
  }

  activateLecture(String token, String lectureID) async {
    Uri url;
    url = Uri.parse(closeLectureApi);
    http.Response res = await http
        .post(url, body: {"Tiktok": token, "Id": lectureID, "status": '0'});
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    if (res.statusCode == 200) {
      var status = jsonDecode(s)['status'];
      return status == '1';
    }
    return false;
  }
}
