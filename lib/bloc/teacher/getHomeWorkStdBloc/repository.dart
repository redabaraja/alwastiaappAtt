import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:alwastia/bloc/teacher/getHomeWorkStdBloc/model.dart';
import 'dart:convert';

import 'package:alwastia/consts.dart';

class GetHomeWorkStudentsRepo {
  Future<List<HomeWorkStudentModel>> getHomeWorkStudents(String token, String assignmentID) async {
    List<HomeWorkStudentModel> data = [];
    Uri url;
    url = Uri.parse(getHomeWorkStdApi);
    http.Response res =
        await http.post(url, body: {"Tiktok": token, "AssignmentID": assignmentID});
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    if (res.statusCode == 200) {
      var d = jsonDecode(s)['data'];
      for (var i = 0; i < d.length; i++) {
        data.add(HomeWorkStudentModel.fromMap(d[i]));
      }
    }
    return data;
  }
}
