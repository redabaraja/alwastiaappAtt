import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';
import 'dart:convert';

import 'package:alwastia/consts.dart';

class SearchForClassesRepo {
  Future<ClassModel2> search(String classID) async {
    Uri url;
    url = Uri.parse(searchForClassApi);
    http.Response res = await http.post(url, body: {"ClassID": classID});
    String s = await Utf8Decoder().convert(res.bodyBytes);
    var d = jsonDecode(s)['data'];
    // print(s);
    return ClassModel2.fromMap(d);
  }

  
}
