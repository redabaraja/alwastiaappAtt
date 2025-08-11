class QuestionModel {
  late int id;
  late String question;
  late String answer;
  late int lectureId;
  late String date;
  QuestionModel(
      {required this.question,
      required this.answer,
      required this.lectureId,
      required this.date,
      required this.id});

  QuestionModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["Id"],
        question = map["Name"],
        answer = map["detail"],
        date = map["createdIn"],
        lectureId = map["LectureID"];
}
