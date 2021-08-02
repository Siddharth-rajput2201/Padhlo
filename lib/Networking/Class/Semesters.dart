class SpecificSemester {
  late Courses courses;

  SpecificSemester({required this.courses});

  SpecificSemester.fromJson(Map<String, dynamic> json) {
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
  late List<Semesters> semesters;

  Courses({required this.course, required this.semesters});

  Courses.fromJson(Map<String, dynamic> json) {
    course = json['course'];
    if (json['semesters'] != null) {
      semesters = <Semesters>[];
      json['semesters'].forEach((v) {
        semesters.add(new Semesters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course'] = this.course;
    data['semesters'] = this.semesters.map((v) => v.toJson()).toList();
    return data;
  }
}

class Semesters {
  late int sem;

  Semesters({required this.sem});

  Semesters.fromJson(Map<String, dynamic> json) {
    sem = json['sem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sem'] = this.sem;
    return data;
  }
}
