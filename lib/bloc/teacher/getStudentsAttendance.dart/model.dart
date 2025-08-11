class StudentAttendanceModel {
  late int id;
  late String userID;
  late String name;
  late int status;
  late String date;
  late String logo;
  late bool isAttended;
  StudentAttendanceModel(
      {required this.userID,
      required this.name,
      required this.status,
      required this.isAttended,
      required this.date,
      required this.logo,
      required this.id});

  StudentAttendanceModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"],
        name = map["name"] == null ? '' : map["name"],
        status = 1,
        isAttended = map["isAttend"],
        date = '',
        logo = map["picture"] == null ? '' : map["picture"],
        userID = map["regNumber"] == null ? '' : map['regNumber'];
}
