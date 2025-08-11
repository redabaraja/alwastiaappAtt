import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

import 'package:alwastia/consts.dart';

class UpdateUserRepo {
  Future updateUserInfo(String token, String name, String email, String phone,
      String city, String address) async {
    Uri url;
    url = Uri.parse(updateuserInfoApi);
    var body = {
      "FullName": name,
      "PhoneNumber": phone,
      "City": city,
      "Country": "اليمن",
      "Address": address,
       "Tiktok": token,
    };

    // var request = new http.MultipartRequest("POST", url);
    // request.fields["Email"] = email;
    // request.fields["FullName"] = name;
    // request.fields["Address"] = address;
    // request.fields["PhoneNumber"] = phone;
    // request.fields["City"] = city;
    // request.fields["Country"] = "اليمن";
    // request.fields["HomeTown"] = city;
    // request.fields["TikTok"] = token;
    // multipart that takes file
    // send
    // var response = await request.send();
    // print(response.statusCode);
    // // listen for response
    // response.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    // });
    // return response.statusCode == 200;
    http.Response res = await http.post(url, body: body);
    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200) {
      return true;
    } else
      return false;
  }
}
