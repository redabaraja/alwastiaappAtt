class HomeWorkStudentModel {
  late int id;
  late String userID;
  late String name;
  late String logo;
  late int assignmentId;
  late String assignmentName;
  late String assignmentDescr;
  late String assignmentDueDate;
  late String fileName;
  late String uploadDate;
  HomeWorkStudentModel(
      {required this.userID,
      required this.name,
      required this.assignmentId,
      required this.assignmentName,
      required this.assignmentDescr,
      required this.assignmentDueDate,
      required this.id,
      required this.fileName,
      required this.logo,
      required this.uploadDate});

  HomeWorkStudentModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["Id"],
        name = map["StudentName"],
        logo = map["photo"],
        userID = map["userID"],
        uploadDate = map["UploadDate"],
        fileName = map["fileName"],
        assignmentId = map["AssignmentId"],
        assignmentName = map["AssignmentName"],
        assignmentDueDate = map["AssignmentDueDate"],
        assignmentDescr = map["AssignmentDescr"];
}
