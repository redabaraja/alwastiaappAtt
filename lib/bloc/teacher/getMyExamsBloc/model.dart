class ExamModel {
  late int id;
  late int classId;
  late String name;
  late int max;
  late String date;
  late int status;
  ExamModel(
      {required this.classId,
      required this.name,
      required this.max,
      required this.date,
      required this.status,
      required this.id});

  ExamModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["Id"],
        name = map["Name"],
        max = map["MaxMark"],
        date = map["createdIn"],
        status= map["status"],
        classId = map["classId"];
}
