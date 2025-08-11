import 'dart:io';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:alwastia/consts.dart';

class LoginRepo {
  Future<List> auth(String username, String password) async {
    List dataModel = [];
    String code;
    String token;
    Uri url;
    url = Uri.parse(authApi);
    http.Response res = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json'
        },
        body: jsonEncode({"email": username, "Password": password}));
    String s = await Utf8Decoder().convert(res.bodyBytes);
    // print(s);
    if (res.statusCode == 200) {
      // code = jsonDecode(s)['code'];

      token = jsonDecode(s)['token'];
      dataModel.add(true);
      dataModel.add(token);
    }
    return dataModel;
  }

  Future<String> auth2(String username, String password) async {
    // await hive.openBox();
    // await hive.userBox.clear();
    // await hive.userBox.close();
    String token = '';
    Uri url;
    url = Uri.parse(authApi2);
    http.Response res = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json'
        },
        body: jsonEncode({"email": username, "Password": password}));
    String s = await Utf8Decoder().convert(res.bodyBytes);
    // print(s);
    if (res.statusCode == 200) {
      token = jsonDecode(s)['token'];
    }
    print(res.statusCode);
    print("\n\n\n${jsonDecode(s)['token']}\n\n");
    return token;
  }

  Future updatePassWord(
      String token, String oldPassword, String newPassword) async {
    Uri url;
    print(token);

    var userinfo;
    url = Uri.parse(updatePasswordApi);

    http.Response res = await http.post(
      url,
      body: {"newPassword": newPassword, "lastPassword": oldPassword},
      headers: {
        // HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    String s = await Utf8Decoder().convert(res.bodyBytes);
    // print(s);
    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200) {
      var data = jsonDecode(s)['data'];
      int st = jsonDecode(s)['st'];
      return [st, data];
    }
    return [0, ''];
  }
}
