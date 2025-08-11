class LectureModel {
  late int id;
  late String ky;
  late String name;
  late String descr;
  late String date;
  late String status;
  LectureModel(
      {required this.ky,
      required this.name,
      required this.descr,
      required this.date,
      required this.status,
      required this.id});

  LectureModel.fromMap(Map<dynamic, dynamic> map,String status)
      : id = map["Id"],
        name = map["Name"],
        descr = map["Descr"],
        date = map["createdIn"],
        status= status,
        ky = map["ky"];
}
