import 'package:async/async.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:alwastia/consts.dart';

class SaveResultRepo {
  Future<bool> save(List<Map> results, String token, String classid) async {
    Uri url;
    print('\n this is the attendance\n');
    print('\n${jsonEncode(results)}\n');
    url = Uri.parse(saveResultApi2 + "?classId=$classid");
    // url = Uri.parse('http://sa.wasatia.edu.ye/api/StudentExams/SaveResult?classId=$classid');
    http.Response res = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: jsonEncode(results),);
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(res.statusCode);
    final redirectUrl = res.headers['location'];
    print(redirectUrl);
    print(s);
    return res.statusCode == 200;
  }
}
