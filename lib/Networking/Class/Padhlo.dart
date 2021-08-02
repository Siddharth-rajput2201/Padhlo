
class Padhlo {
  late List<Courses> courses;

  Padhlo({required this.courses});

  Padhlo.fromJson(Map<String, dynamic> json) {
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
  late List<Subjects> subjects;

  Semesters({required this.sem, required this.subjects});

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
  late List<Units> units;

  Subjects({required this.subject,required  this.units});

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
  late List<Topics> topics;

  Units({required this.unit,required  this.pdfName,required  this.pdfUrl,required  this.topics});

  Units.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    pdfName = json['pdfName'];
    pdfUrl = json['pdfUrl'];
    if (json['topics'] != null) {
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics.add(new Topics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unit'] = this.unit;
    data['pdfName'] = this.pdfName;
    data['pdfUrl'] = this.pdfUrl;
    data['topics'] = this.topics.map((v) => v.toJson()).toList();
    return data;
  }
}

class Topics {
  late String topic;
  late String youtubeUrl;

  Topics({required this.topic,required this.youtubeUrl});

  Topics.fromJson(Map<String, dynamic> json) {
    topic = json['topic'];
    youtubeUrl = json['youtubeUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topic'] = this.topic;
    data['youtubeUrl'] = this.youtubeUrl;
    return data;
  }
}
