// class ClassModel {
//   late int id;
//   late String ky;
//   late String name;
//   late String descr;
//   late String passCode;
//   late String logo;
//   late String userId;
//   late String date;
//   late int stdCount;

//   ClassModel(
//       {required this.ky,
//       required this.name,
//       required this.descr,
//       required this.userId,
//       required this.logo,
//       required this.passCode,
//       required this.stdCount,
//       required this.date,
//       required this.id});

//   ClassModel.fromMap(Map<dynamic, dynamic> map)
//       : id = map["Id"],
//         name = map["Name"],
//         userId = map["userID"],
//         descr = map["Descr"],
//         passCode = map["passCode"],
//         logo = map["Logo"],
//         stdCount = map["stuCount"],
//         date = map["createdIn"],
//         ky = map["ky"];
// }
class ClassModel {
  late int id;
  late String name;
  late int credit;
  late String level;
  late String major;
  late String image;
  ClassModel(
      {
      required this.name,
      required this.level,
      required this.credit,
      required this.major,
      required this.image,
      required this.id});

  ClassModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"],
        name = map["name"],
        level = map["level"],
        major = map["specialist"],
        image=map['image']??'',
        credit = map["credit"];
}

