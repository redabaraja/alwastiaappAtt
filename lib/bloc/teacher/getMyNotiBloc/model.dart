class NotiModel {
  late int id;
  late int classId;
  late String name;
  late String descr;
  late String date;
  NotiModel(
      {required this.classId,
      required this.name,
      required this.descr,
      required this.date,
      required this.id});

  NotiModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["Id"],
        name = map["Name"],
        descr = map["detail"],
        date = map["createdIn"],
        classId= map["classID"];
}
