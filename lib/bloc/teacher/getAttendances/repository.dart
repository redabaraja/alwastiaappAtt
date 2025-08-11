import 'package:alwastia/bloc/teacher/getAttendances/model.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:alwastia/bloc/teacher/getMyLecturesBloc/model.dart';
import 'dart:convert';

import 'package:alwastia/consts.dart';

class GetAttendanceDatesRepo {
  Future<List<AtendanceDatesModel>> getLectures(
      String token, String classID) async {
    List<AtendanceDatesModel> data = [];
    Uri url;
    url = Uri.parse(attendanceDatesApi + "?id=$classID");
    http.Response res = await http.post(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    if (res.statusCode == 200) {
      var d = jsonDecode(s)['data'];
      print('/n/n$d/n/n');
      print(classID);
      if (d!= "") {
        for (var element in d) {
          data.add(AtendanceDatesModel.fromMap(element));
        }
      } else {
        print('it is empty');
      }
    }
    return data;
  }
}
