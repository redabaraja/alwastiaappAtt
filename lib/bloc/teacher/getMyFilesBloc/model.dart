class FileModel {
  late int id;
  late String title;
  late String descr;
  late String fileName;
  late String fileType;
  late int lectureID;
  late String date;
  FileModel(
      {required this.date,
      required this.title,
      required this.descr,
      required this.lectureID,
      required this.fileName,
      required this.fileType,
      required this.id});

  FileModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["Id"],
        lectureID = map["LectureID"],
        title = map["Title"],
        descr = map["Descr"],
        fileName = map["FileName"],
        fileType = map["FileType"],
        date = map["createdIn"];
}
