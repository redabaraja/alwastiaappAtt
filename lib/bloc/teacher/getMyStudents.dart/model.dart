class StudentModel {
  late int id;
  late String userID;
  late String name;
  late int status;
  late String date;
  late String logo;
  StudentModel(
      {required this.userID,
      required this.name,
      required this.status,
      required this.date,
      required this.logo,
      required this.id});

  StudentModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"],
        name = map["name"] == null ? '' : map["name"],
        status = 1,
        date = '',
        logo = map["picture"] == null ? '' : map["picture"],
        userID = map["regNumber"];
}
