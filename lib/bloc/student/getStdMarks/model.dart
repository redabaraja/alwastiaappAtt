class MarksModel {
  late int id;
  late int studentId;
  late String studentName;
  late int classId;
  late String picture;
  late int firstMonthTheory;
  late int secondMonthTheory;
  late int firstMonthPractical;
  late int secondMonthPractical;
  late int degreeOfTheoryWork;
  late int degreeOfPractice;
  late int degreeOfFinalTheory;
  late int degreeOfFinalPractice;

  MarksModel(
      {required this.id,
      required this.studentId,
      required this.studentName,
      required this.classId,
      required this.firstMonthTheory,
      required this.secondMonthTheory,
      required this.firstMonthPractical,
      required this.secondMonthPractical,
      required this.degreeOfTheoryWork,
      required this.degreeOfPractice,
      required this.degreeOfFinalTheory,
      required this.degreeOfFinalPractice,
      required this.picture});

  factory MarksModel.fromJson(Map<String, dynamic> json) {
    return MarksModel(
      id: json['id'] ?? 0,
      studentId: json['studentId'] ?? 0,
      studentName: json['studentName'] ?? '',
      classId: json['classId'] ?? 0,
      picture: json['picture'] ?? '',
      firstMonthTheory: json['firstMonthTheory'] ?? 0,
      secondMonthTheory: json['secondMonthTheory'] ?? 0,
      firstMonthPractical: json['firstMonthPractical'] ?? 0,
      secondMonthPractical: json['secondMonthPractical'] ?? 0,
      degreeOfTheoryWork: json['degreeOfTheoryWork'] ?? 0,
      degreeOfPractice: json['degreeOfPractice'] ?? 0,
      degreeOfFinalTheory: json['degreeOfFinalTheory'] ?? 0,
      degreeOfFinalPractice: json['degreeOfFinalPractice'] ?? 0,
    );
  }
  static Map<String, dynamic> toJson(MarksModel d) {
    return {
      'id': d.id,
      'studentId': d.studentId,
      'studentName': d.studentName,
      'classId': d.classId,
      'picture': d.picture,
      'firstMonthTheory': d.firstMonthTheory,
      'secondMonthTheory': d.secondMonthTheory,
      'firstMonthPractical': d.firstMonthPractical,
      'secondMonthPractical': d.secondMonthPractical,
      'degreeOfTheoryWork': d.degreeOfTheoryWork,
      'degreeOfPractice': d.degreeOfPractice,
      'degreeOfFinalTheory': d.degreeOfFinalTheory,
      'degreeOfFinalPractice': d.degreeOfFinalPractice,
    };
  }
}

class MarksModelMain {
  late String subject;
  late List<MarksModel> results;
  MarksModelMain({required this.subject, required this.results});

  MarksModelMain.fromJson(Map<String, dynamic> json) {
    subject = json['subject'] ?? '';
    results = [];
    for (var element in json['results']) {
      results.add(MarksModel.fromJson(element));
    }
  }
}
