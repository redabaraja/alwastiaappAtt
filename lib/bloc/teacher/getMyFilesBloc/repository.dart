import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:alwastia/bloc/teacher/getMyFilesBloc/model.dart';
import 'dart:convert';

import 'package:alwastia/consts.dart';

class GetFilesRepo {
  Future<List<FileModel>> getFiles(String token, String lectureid) async {
    List<FileModel> data = [];
    Uri url;
    url = Uri.parse(getFilesApi);
    http.Response res =
        await http.post(url, body: {"Tiktok": token, "LectureID": lectureid});
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    if (res.statusCode == 200) {
      var d = jsonDecode(s)['data'];
      for (var i = 0; i < d.length; i++) {
        data.add(FileModel.fromMap(d[i]));
      }
    }
    return data;
  }
}
