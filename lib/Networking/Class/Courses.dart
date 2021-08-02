class SpecificCourse {
  late List<Courses> courses;

  SpecificCourse({required this.courses});

  SpecificCourse.fromJson(Map<String, dynamic> json) {
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses.add(new Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courses'] = this.courses.map((v) => v.toJson()).toList();
    return data;
  }
}

class Courses {
  late String course;

  Courses({required this.course});

  Courses.fromJson(Map<String, dynamic> json) {
    course = json['course'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course'] = this.course;
    return data;
  }
}
