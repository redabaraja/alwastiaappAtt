import 'dart:io';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:alwastia/bloc/student/profileBloc/localdata.dart';
import 'package:alwastia/consts.dart';

class ProfileRepo {
  Future getUserInfo(String token) async {
    Uri url;
    print(token);

    LocalUserInfo hive = LocalUserInfo();
    var userinfo;
    url = Uri.parse(userInfoApi2);

    http.Response res = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    String s = await Utf8Decoder().convert(res.bodyBytes);
    // print(s);
    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200) {
      var data = jsonDecode(s)['data'];
      print(data);
      await hive.openBox();
      await hive.addData(data);
      // await hive.userinfoBox.close();
      // UserModel userdata = UserModel.fromMap(data);
      // userinfo = userdata;
    }
  }

  Future updatePassWord(
      String token, String oldPassword, String newPassword) async {
    Uri url;
    print(token);

    LocalUserInfo hive = LocalUserInfo();
    var userinfo;
    url = Uri.parse(updatePasswordApi);

    http.Response res = await http.post(
      url,
      body: {"newPassword": newPassword, "lastPassword": oldPassword},
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    String s = await Utf8Decoder().convert(res.bodyBytes);
    // print(s);
    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200) {
      var data = jsonDecode(s)['data'];
    }
  }

  uploadProfileImage(File imageFile, String token) async {
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();
    // string to uri
    Uri url = Uri.parse(updateuserImageApi);

    // create multipart request
    var request = new http.MultipartRequest("POST", url);
    request.fields["TikTok"] = token;
    // multipart that takes file
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    // add file to multipart
    request.files.add(multipartFile);
    // send
    var response = await request.send();
    print(response.statusCode);
    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
    return response.statusCode == 200;
  }
}
