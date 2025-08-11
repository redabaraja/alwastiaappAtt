class AtendanceDatesModel {
  late String id;
  late String name;
  late String hours;

  AtendanceDatesModel({required this.name, required this.id});

  AtendanceDatesModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"],
        hours = map["hours"].toString(),
        name = map["name"];
}
