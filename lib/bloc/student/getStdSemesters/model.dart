class SemesterModel {
  late int id;
  late String name;

  SemesterModel({
    required this.id,
    required this.name,
  });

  SemesterModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"],
        name = map["name"];
}
