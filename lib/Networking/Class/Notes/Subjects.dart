class SpecificSubject {
  late Courses courses;

  SpecificSubject({required this.courses});

  SpecificSubject.fromJson(Map<String, dynamic> json) {
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
  late List<Subjects> subjects;

  Semesters({required this.sem,required this.subjects});

  Semesters.fromJson(Map<String, dynamic> json) {
    sem = json['sem'];
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects.add(new Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sem'] = this.sem;
    data['subjects'] = this.subjects.map((v) => v.toJson()).toList();
    return data;
  }
}

class Subjects {
  late String subject;
  late String subjectBookName;
  late String subjectBookUrl;

  Subjects({required this.subject,required this.subjectBookName,required this.subjectBookUrl});

  Subjects.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    subjectBookName = json['subjectBookName'];
    subjectBookUrl = json['subjectBookUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['subjectBookName'] = this.subjectBookName;
    data['subjectBookUrl'] = this.subjectBookUrl;
    return data;
  }
}