import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:alwastia/bloc/teacher/gethomeworks/model.dart';
import 'dart:convert';

import 'package:alwastia/consts.dart';

class GetHomeWorkRepo {
  Future<List<HomeWorkModel>> getHomeWork(String token, String classID) async {
    List<HomeWorkModel> data = [];
    Uri url;
    url = Uri.parse(getHomeWorkApi);
    http.Response res =
        await http.post(url, body: {"Tiktok": token, "ClassID": classID});
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    if (res.statusCode == 200) {
      var d = jsonDecode(s)['data'];
      for (var i = 0; i < d.length; i++) {
        data.add(HomeWorkModel.fromMap(d[i]));
      }
    }
    return data;
  }
}
