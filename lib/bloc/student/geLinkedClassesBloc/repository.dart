import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';
import 'dart:convert';
import 'dart:io';

import 'package:alwastia/consts.dart';

class GetLinkedClassesRepo {
  

  Future<List<ClassModel2>> getLinkedClasses(String token) async {
    List<ClassModel2> data = [];
    Uri url;
    url = Uri.parse(getLinkedClassesApi2);
    http.Response res = await http.get(
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
        data.add(ClassModel2.fromMap(d[i]));
      }
    }
    return data;
  }
}
