class TeacherModle {
  late String id;
  late String name;
  late String phone;
  late String address;
  late String degree;
  late String username;
  late String password;
  TeacherModle({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.degree,
    required this.username,
    required this.password,
  });

  // TeacherModle.fromMap(Map<dynamic, dynamic> map)
  //     : id = map["id"],
  //       title = map["title"],
  //       text = map["text"],
  //       wrongWords = map["wrong_words"];
}
