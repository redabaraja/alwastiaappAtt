import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:alwastia/consts.dart';

class LinkClassesRepo {
  Future<bool> linkClass(String classID, String token, String passcode) async {
    Uri url;
    url = Uri.parse(linkclassApi);
    print(passcode);
    print(classID);
    http.Response res = await http.post(url,
        body: {"Tiktok": token, "ClassID": classID, "passCode": passcode});
    String s = await Utf8Decoder().convert(res.bodyBytes);

    if (res.statusCode == 200) {
      print(s);
      var d = jsonDecode(s)['status'];
      return d == "1";
    } else {
      return false;
    }
  }
}
