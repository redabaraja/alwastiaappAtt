class OneStudentAttendanceModel {
  late int id;
  late String name;
  late int attendance;
  late String date;
  OneStudentAttendanceModel(
      {required this.name,
      required this.attendance,
      required this.date,
      required this.id});

  OneStudentAttendanceModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["Id"],
        name = map["Name"],
        attendance = map["isttended"],
        date = map["createdIn"];
}
