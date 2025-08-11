import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:alwastia/bloc/teacher/getMyNotiBloc/model.dart';
import 'dart:convert';

import 'package:alwastia/consts.dart';

class GetNotisRepo {
  Future<List<NotiModel>> getNoti(String token, String classID) async {
    List<NotiModel> data = [];
    Uri url;
    url = Uri.parse(getNotiApi);
    http.Response res =
        await http.post(url, body: {"Tiktok": token, "ClassID": classID});
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    if (res.statusCode == 200) {
      var d = jsonDecode(s)['data'];
      for (var i = 0; i < d.length; i++) {
        data.add(NotiModel.fromMap(d[i]));
      }
    }
    return data;
  }

}
