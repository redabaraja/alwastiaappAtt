import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:alwastia/consts.dart';

class SignUpRepo {
  Future<List> auth(String username, String password) async {
    List dataModel = [];
    String code;
    String token;
    Uri url;
    url = Uri.parse(authApi);
    http.Response res =
        await http.post(url, body: {"uername": username, "password": password});
    String s = await Utf8Decoder().convert(res.bodyBytes);
    // print(s);
    if (res.statusCode == 200) {
      code = jsonDecode(s)['code'];
      if (code != "304") {
        token = jsonDecode(s)['token'];
        dataModel.add(true);
        dataModel.add(token);
      } else {
        dataModel.add(false);
        dataModel.add("");
      }
    }
    return dataModel;
  }

  Future<bool> signUp(String uname, String password, String phone,
      String address, String name, String email) async {
    List dataModel = [];
    String code;
    String token;
    Uri url;
    url = Uri.parse(signUpApi);
    var body = {
      "uname": uname,
      "Email": email,
      "password": password,
      "cpassword": password,
      "FullName": name,
      "PhoneNumber": phone,
      "Address": address,
      "City": '',
      "Country":'',
      "HomeTown":'',
      "RoleID": "58f30fa0-3dc6-420b-943d-3172bd3d03f1"
    };
    // headers: {HttpHeaders.contentTypeHeader:'application/json'}
    http.Response res = await http.post(url, body: body);
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    if (res.statusCode == 200) {
      code = jsonDecode(s)['code'];
      if (code == "1") {
        return true;
      } else {
        return false;
      }
    } else
      return false;
  }
}
