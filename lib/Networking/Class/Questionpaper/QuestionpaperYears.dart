class QuestionpaperSpecificYears {
  late Courses courses;

  QuestionpaperSpecificYears({required this.courses});

  QuestionpaperSpecificYears.fromJson(Map<String, dynamic> json) {
    courses =
        (json['courses'] != null ? new Courses.fromJson(json['courses']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courses'] = this.courses.toJson();
    return data;
  }
}

class Courses {
  late String course;
  late Semesters semesters;

  Courses({required this.course,required this.semesters});

  Courses.fromJson(Map<String, dynamic> json) {
    course = json['course'];
    semesters = (json['semesters'] != null
        ? new Semesters.fromJson(json['semesters'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course'] = this.course;
    data['semesters'] = this.semesters.toJson();
    return data;
  }
}

class Semesters {
  late int sem;
  late Subjects subjects;

  Semesters({required this.sem,required this.subjects});

  Semesters.fromJson(Map<String, dynamic> json) {
    sem = json['sem'];
    subjects = (json['subjects'] != null
        ? new Subjects.fromJson(json['subjects'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sem'] = this.sem;
    data['subjects'] = this.subjects.toJson();
    return data;
  }
}

class Subjects {
  late String subject;
  late List<Years> years;

  Subjects({required this.subject,required this.years});

  Subjects.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    if (json['years'] != null) {
      years = <Years>[];
      json['years'].forEach((v) {
        years.add(new Years.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['years'] = this.years.map((v) => v.toJson()).toList();
    return data;
  }
}

class Years {
  late int year;
  late String pdfName;
  late String pdfUrl;

  Years({required this.year,required this.pdfName,required this.pdfUrl});

  Years.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    pdfName = json['pdfName'];
    pdfUrl = json['pdfUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['pdfName'] = this.pdfName;
    data['pdfUrl'] = this.pdfUrl;
    return data;
  }
}
