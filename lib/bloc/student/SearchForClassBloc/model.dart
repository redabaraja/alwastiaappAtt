class ClassModel2 {
  late int id;
  late String name;
  late String teacher;
  late int credit;
  late int stdCount;
  late String image;
  ClassModel2(
      {required this.id,
      required this.name,
      required this.credit,
      required this.teacher,
      required this.image,
      required this.stdCount});

  ClassModel2.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"],
        name = map["name"],
        teacher = map['teacher'],
        credit = map["credit"],
        image = map['image'] ?? '',
        stdCount = map["studentCount"];
}
