import 'dart:io';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:alwastia/bloc/teacher/getMyClassesBloc/model.dart';
import 'dart:convert';

import 'package:alwastia/consts.dart';

class GetClassesRepo {
  Future<bool> createClass(String name, String descr, String token) async {
    Uri url;
    url = Uri.parse(createClassApi);
    http.Response res = await http.post(url, body: {
      "Name": name,
      "Descr": descr,
      "id": '',
      "Logo": '',
      "Tiktok": token
    });
    String s = await Utf8Decoder().convert(res.bodyBytes);
    // print(s);
    return res.statusCode == 200;
  }

  Future<List<ClassModel>> getClasses(String token, String status) async {
    List<ClassModel> data = [];
    Uri url;
    url = Uri.parse(getTeacherClassesApi);
    http.Response res =
        await http.post(url, body: {"Tiktok": token, "status": status});
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    if (res.statusCode == 200) {
      var d = jsonDecode(s)['data'];
      for (var i = 0; i < d.length; i++) {
        data.add(ClassModel.fromMap(d[i]));
      }
    }
    return data;
  }
 Future<List<ClassModel>> getClasses2(String token) async {
    List<ClassModel> data = [];
     Uri url;
    url = Uri.parse(getTeacherClassesApi2);
    http.Response res = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    if (res.statusCode == 200) {
      var d = jsonDecode(s)['data'];
      for (var i = 0; i < d.length; i++) {
        data.add(ClassModel.fromMap(d[i]));
      }
    }
    return data;
  }

}
