class HomeWorkModel {
  late int id;
  late int classId;
  late String name;
  late String descr;
  late String date;
  late String createIn;
  HomeWorkModel(
      {required this.classId,
      required this.name,
      required this.descr,
      required this.date,
      required this.createIn,
      required this.id});

  HomeWorkModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["Id"],
        name = map["Name"],
        descr = map["Descr"],
        date = map["DueDate"],
        createIn = map["createdIn"],
        classId = map["classId"];
}
