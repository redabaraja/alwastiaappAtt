class MarksModel2 {
  late String studentName;
  late String classnName;
  late int creditHrs;
  late int stuId;
  late String regNumber;
  late int firstMonthTheory;
  late int secondMonthTheory;
  late int firstMonthPractical;
  late int secondMonthPractical;
  late int finalMark;
  late int monthlyTotalMark;

  MarksModel2(
      {required this.stuId,
      required this.studentName,
      required this.classnName,
      required this.firstMonthTheory,
      required this.secondMonthTheory,
      required this.firstMonthPractical,
      required this.secondMonthPractical,
      required this.creditHrs,
      required this.regNumber,
      required this.monthlyTotalMark,
      required this.finalMark});

  factory MarksModel2.fromJson(Map<String, dynamic> json) {
    return MarksModel2(
      studentName: json['studentName'] ?? '',
      classnName: json['classnName'] ?? '',
      creditHrs: json['picture'] ?? 0,
      firstMonthTheory: json['month1_Mark'] ?? 0,
      secondMonthTheory: json['month2_Mark'] ?? 0,
      firstMonthPractical: json['practical1_Mark'] ?? 0,
      secondMonthPractical: json['practical2_Mark'] ?? 0,
      stuId: json['stuId'] ?? 0,
      regNumber: json['regNumber'] ?? '',
      finalMark: json['final_Mark'] ?? 0,
      monthlyTotalMark: json['monthly_total_Mark'] ?? 0,
    );
  }
}

class ResultModel {
  late int st;
  late List<MarksModel2> marksData;
  late int total;
  late int failsPer;
  late int failsCount;
  late String grade;
  late String note;

  ResultModel({
    required this.marksData,
    required this.failsCount,
    required this.failsPer,
    required this.grade,
    required this.note,
    required this.st,
    required this.total,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    List<MarksModel2> marks = [];
    for (var i = 0; i < json['marks_data'].length; i++) {
      marks.add(MarksModel2.fromJson(json['marks_data'][i]));
    }

    return ResultModel(
        st: json['st'] ?? 0,
        total: json['total'] ?? 0,
        failsPer: json['failsPer'] ?? 0,
        failsCount: json['failsCount'] ?? 0,
        grade: json['grade'] ?? '',
        note: json['note'] ?? '',
        marksData: marks);
  }
}
