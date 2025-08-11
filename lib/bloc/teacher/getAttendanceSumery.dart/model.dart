class AttendanceSummeryModel {
  late int id;
  late String userID;
  late String name;
  late String exe;
  late String noexe;
  late String total;
  late String result;
  AttendanceSummeryModel(
      {required this.userID,
      required this.name,
      required this.total,
      required this.noexe,
      required this.exe,
      required this.result,
      required this.id});

  AttendanceSummeryModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"],
        name = map["name"],
        exe = map["execuse"].toString(),
        noexe = map["nonExecuse"].toString(),
        total = map["total"].toString(),
        result = map["result"],
        userID = map["regNumber"];
}

class AttendancedetailsModel {
  late int id;
  late String date;
  late String lecture;
  late String hours;
  late String exhours;
  late String note;
  AttendancedetailsModel(
      {required this.date,
      required this.lecture,
      required this.hours,
      required this.exhours,
      required this.note,
      required this.id});

  AttendancedetailsModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"],
        date = map["atFromDate"] ?? '',
        lecture = map["atLecture"].toString(),
        hours = map["upsentHours"].toString(),
        exhours = map["exUpsentHours"].toString(),
        note = map["note"] ?? '';
}
