class UserModel {
  late String id;
  late String email;
  late String name;
  late String number;
  late String adress;
  late String role;
  late String logo;
  late String level;
  late String dept;
  late String major;
  late String college;
  UserModel(
      {required this.email,
      required this.name,
      required this.number,
      required this.role,
      required this.adress,
      required this.logo,
      required this.college,
      required this.dept,
      required this.level,
      required this.major,
      required this.id});

  UserModel.fromMap(Map<dynamic, dynamic> map)
      : email = map["email"] ?? '',
        name = map["name"] ?? '',
        id = map["id"].toString(),
        number = map["phoneNumber"] == null ? 'غير متوفر' : map["phoneNumber"],
        adress = map["address"] == null ? 'غير متوفر' : map["address"],
        logo = map["photo"] == null ? '' : map["photo"],
        level = map["level"] ?? 'غير متوفر',
        dept = map["department"] == null ? 'غير متوفر' : map["department"],
        major = map["specialist"] == null ? 'غير متوفر' : map["specialist"],
        college = map["college"] == null ? '' : map["college"],
        role = map["role"];
}
