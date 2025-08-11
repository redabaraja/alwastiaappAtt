import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:alwastia/bloc/teacher/getAttendanceSumery.dart/model.dart';
import 'dart:convert';

import 'package:alwastia/consts.dart';

class GetClassAttendanceSummeryRepo {
  Future<List<AttendanceSummeryModel>> getAttendanceSummery(
      String token, String classID) async {
    List<AttendanceSummeryModel> data = [];
    Uri url;
    url = Uri.parse(getClassAttendanceSummeryApi2 + "?classId=$classID");
    http.Response res = await http.post(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    String s = await Utf8Decoder().convert(res.bodyBytes);
    // print('\n\n'+s+'\n\n');
    if (res.statusCode == 200) {
      var d = jsonDecode(s)['data'];
      print('\n\n' + d.length.toString() + '\n\n');
      // print('\n\n'+d.toString()+'\n\n');
      // for (var i = 0; i < d.length; i++) {
      //   print('\n\n' + d[i].toString() + '\n\n');
      // }
      //  print('\n\n' + d[d.length].toString() + '\n\n');
      for (var i = 0; i < d.length; i++) {
        data.add(AttendanceSummeryModel.fromMap(d[i]));
      }
    }
    return data;
  }

  Future<List<AttendanceSummeryModel>> getOneAttendanceSummery(
      String token, String classID) async {
    print('we are in the repo');
    List<AttendanceSummeryModel> data = [];
    Uri url;
    url = Uri.parse(getStdAttendanceSummeryApi2 + "?classId=$classID");
    http.Response res = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    String s = await Utf8Decoder().convert(res.bodyBytes);

    print(s);
    if (res.statusCode == 200) {
      var d = jsonDecode(s)['data'];

      data.add(AttendanceSummeryModel.fromMap(d));
    }
    return data;
  }

  Future<List<AttendancedetailsModel>> getAttendanceDetails(
      String token, String classID) async {
    List<AttendancedetailsModel> data = [];
    Uri url;
    url = Uri.parse(getStdAttendanceDetailsApi2 + "?classId=$classID");
    http.Response res = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    String s = await Utf8Decoder().convert(res.bodyBytes);
    // print('\n\n'+s+'\n\n');
    if (res.statusCode == 200) {
      var d = jsonDecode(s)['data'];
      print('\n\n' + d.length.toString() + '\n\n');

      for (var i = 0; i < d.length; i++) {
        data.add(AttendancedetailsModel.fromMap(d[i]));
      }
    }
    return data;
  }
}
