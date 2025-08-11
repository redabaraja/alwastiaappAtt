import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:alwastia/bloc/teacher/StudentAttendanceBloc/model.dart';
import 'dart:convert';

import 'package:alwastia/consts.dart';

class OneStudentAttendanceRepo {
  Future<List<OneStudentAttendanceModel>> getAttendanceSummery(String token, String classID) async {
    List<OneStudentAttendanceModel> data = [];
    Uri url;
    url = Uri.parse(getOneStudentAttendanceApi);
    http.Response res =
        await http.post(url, body: {"Tiktok": token, "classID": classID});
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    if (res.statusCode == 200) {
      var d = jsonDecode(s)['data'];
      for (var i = 0; i < d.length; i++) {
        data.add(OneStudentAttendanceModel.fromMap(d[i]));
      }
    }
    return data;
  }
}
