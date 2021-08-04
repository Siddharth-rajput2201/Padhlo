class SpecificUnit {
  late Courses courses;

  SpecificUnit({required this.courses});

  SpecificUnit.fromJson(Map<String, dynamic> json) {
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
  late List<Units> units;

  Subjects({required this.subject,required this.units});

  Subjects.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    if (json['units'] != null) {
      units = <Units>[];
      json['units'].forEach((v) {
        units.add(new Units.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['units'] = this.units.map((v) => v.toJson()).toList();
    return data;
  }
}

class Units {
  late int unit;
  late String pdfName;
  late String pdfUrl;

  Units({required this.unit,required this.pdfName,required this.pdfUrl});

  Units.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    pdfName = json['pdfName'];
    pdfUrl = json['pdfUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unit'] = this.unit;
    data['pdfName'] = this.pdfName;
    data['pdfUrl'] = this.pdfUrl;
    return data;
  }
}
