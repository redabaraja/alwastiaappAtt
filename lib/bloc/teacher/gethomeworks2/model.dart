class HomeWorkModel2 {
  late int id;
  late int classId;
  late String name;
  late String descr;
  late String date;
  late String createIn;
  late String filename;
  late bool status;
  HomeWorkModel2(
      {required this.classId,
      required this.name,
      required this.descr,
      required this.date,
      required this.createIn,
      required this.filename,
      required this.status,
      required this.id});

  HomeWorkModel2.fromMap(Map<dynamic, dynamic> map)
      : id = map["Id"],
        name = map["Name"],
        descr = map["Descr"],
        date = map["DueDate"],
        createIn = map["createdIn"],
        filename = map["filename"],
        status = map["status"],
        classId = map["classId"];
}
