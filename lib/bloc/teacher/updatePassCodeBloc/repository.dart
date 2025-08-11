import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:alwastia/consts.dart';

class UpdatePassCodeRepo {
  Future<bool> updatePasscode(String token, String id, String passcode) async {
    Uri url;
    url = Uri.parse(updatePassCodeApi);
    http.Response res = await http
        .post(url, body: {"passCode": passcode, "Id": id, "Tiktok": token});
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    return res.statusCode == 200;
  }
}
