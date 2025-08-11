import 'package:async/async.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:alwastia/consts.dart';

class SaveAttendanceRepo {
  Future<bool> save(List<Map> attendance, String lectureid, String token,
      int classid, String hours) async {
    Uri url;
    print('\n this is the attendance\n');
    print('\n$attendance\n');
    url = Uri.parse(saveAttendanceApi2 +
        "?classId=$classid&$lectureid&hours=$hours");
    http.Response res = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: jsonEncode(attendance));
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(res.statusCode);
    print(s);
    return res.statusCode == 200;
  }
}
