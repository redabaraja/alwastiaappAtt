import 'dart:io';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:alwastia/consts.dart';

class CreateFileRepo {
  uploadFile(
    File imageFile,
    String token,
    String lectureid,
    String title,
  ) async {
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();
    // string to uri
    Uri url = Uri.parse(uploadFileApi);
    print(token);
    print(title);
    print(lectureid.toString());
    // create multipart request
    var request = new http.MultipartRequest("POST", url);
    request.fields["Tiktok"] = token;
    request.fields["LectureID"] = lectureid;
    request.fields["Title"] = title;
    request.fields["Descr"] = 'defualt';
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
