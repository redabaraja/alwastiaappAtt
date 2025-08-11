import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:alwastia/bloc/teacher/getMyQuestionsBloc/model.dart';
import 'dart:convert';

import 'package:alwastia/consts.dart';

class GetQuestionRepo {
  Future<List<QuestionModel>> getQuestions(
      String token, String questionId) async {
    List<QuestionModel> data = [];
    Uri url;
    url = Uri.parse(getQuestionApi);
    http.Response res =
        await http.post(url, body: {"Tiktok": token, "LectureID": questionId});
    String s = await Utf8Decoder().convert(res.bodyBytes);
    print(s);
    if (res.statusCode == 200) {
      var d = jsonDecode(s)['data'];
      for (var i = 0; i < d.length; i++) {
        data.add(QuestionModel.fromMap(d[i]));
      }
    }
    return data;
  }
}
