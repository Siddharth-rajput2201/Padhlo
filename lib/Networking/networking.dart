import 'package:http/http.dart' as http;
import 'package:padhlo/Networking/Api.dart';
import 'package:padhlo/Networking/Class/Notes/Courses.dart';
import 'dart:convert';
import 'package:padhlo/Networking/Class/Notes/Padhlo.dart';
import 'package:padhlo/Networking/Class/Notes/Semesters.dart';
import 'package:padhlo/Networking/Class/Notes/Subjects.dart';
import 'package:padhlo/Networking/Class/Notes/Topics.dart';
import 'package:padhlo/Networking/Class/Notes/Units.dart';
import 'package:padhlo/Networking/Class/Questionpaper/QuestionpaperCourses.dart';
import 'package:padhlo/Networking/Class/Questionpaper/QuestionpaperSemesters.dart';
import 'package:padhlo/Networking/Class/Questionpaper/QuestionpaperSubject.dart';
import 'package:padhlo/Networking/Class/Questionpaper/QuestionpaperYears.dart';

class Networking {

  static Future<List<Padhlo>> getAllData() async {
    http.Response response;
    response = await http.get(Uri.parse(Api.getAllData));
    //print(response.body);
    List data;
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      return data.map((e) => Padhlo.fromJson(e)).toList();
      // Padhlo padhlo = Padhlo.fromJson(json.decode(response.body));
      // return padhlo;
    } else {
      return [];
    }
  }

  static Future<List<SpecificCourse>> getAllCourses() async {
    http.Response response;
    response = await http.post(Uri.parse(Api.getAllCourse));
    List data;
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      return data.map((e) => SpecificCourse.fromJson(e)).toList();
      // Padhlo padhlo = Padhlo.fromJson(json.decode(response.body));
      // return padhlo;
    } else {
      return [];
    }
  }

  static Future<List<SpecificSemester>> getAllSemester(String course) async {
    http.Response response;
    response = await http.post(
      Uri.parse(Api.getSemester),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
       body: {"course": course},
    );
    List data;
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      return data.map((e) => SpecificSemester.fromJson(e)).toList();
      // Padhlo padhlo = Padhlo.fromJson(json.decode(response.body));
      // return padhlo;
    } else {
      return [];
    }
  }

  static Future<List<SpecificSubject>> getAllSubject(String course,String semester) async {
  http.Response response;
  response = await http.post(
    Uri.parse(Api.getSubject),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    encoding: Encoding.getByName('utf-8'),
      body: {
        "course": course,
        "semester":semester
        },
  );
  List data;
  if (response.statusCode == 200) {
    data = json.decode(response.body);
    return data.map((e) => SpecificSubject.fromJson(e)).toList();
    // Padhlo padhlo = Padhlo.fromJson(json.decode(response.body));
    // return padhlo;
  } else {
    return [];
  }
}

  static Future<List<SpecificUnit>> getAllUnit(String course,String semester,String subject) async {
  http.Response response;
  response = await http.post(
    Uri.parse(Api.getUnit),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    encoding: Encoding.getByName('utf-8'),
      body: {
        "course": course,
        "semester":semester,
        "subject" : subject
        },
  );
  List data;
  if (response.statusCode == 200) {
    data = json.decode(response.body);
    return data.map((e) => SpecificUnit.fromJson(e)).toList();
    // Padhlo padhlo = Padhlo.fromJson(json.decode(response.body));
    // return padhlo;
  } else {
    return [];
  }
}

  static Future<List<SpecificTopic>> getAllTopic(String course,String semester,String subject,String unit) async {
  http.Response response;
  response = await http.post(
    Uri.parse(Api.getTopic),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    encoding: Encoding.getByName('utf-8'),
      body: {
        "course": course,
        "semester":semester,
        "subject" : subject,
        "unit" : unit
        },
  );
  List data;
  if (response.statusCode == 200) {
    data = json.decode(response.body);
    return data.map((e) => SpecificTopic.fromJson(e)).toList();
    // Padhlo padhlo = Padhlo.fromJson(json.decode(response.body));
    // return padhlo;
  } else {
    return [];
  }
}

  static Future<List<QuestionpaperSpecificCourse>> getAllQuestionpaperCourses() async {
    http.Response response;
    response = await http.post(Uri.parse(Api.getQuestionpaperCourse));
    List data;
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      return data.map((e) => QuestionpaperSpecificCourse.fromJson(e)).toList();
      // Padhlo padhlo = Padhlo.fromJson(json.decode(response.body));
      // return padhlo;
    } else {
      return [];
    }
  }

  static Future<List<QuestionpaperSpecificSemester>> getAllQuestionpaperSemester(String course) async {
    http.Response response;
    response = await http.post(
      Uri.parse(Api.getQuestionpaperSemester),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
       body: {"course": course},
    );
    List data;
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      return data.map((e) => QuestionpaperSpecificSemester.fromJson(e)).toList();
      // Padhlo padhlo = Padhlo.fromJson(json.decode(response.body));
      // return padhlo;
    } else {
      return [];
    }
  }
 
  static Future<List<QuestionpaperSpecificSubject>> getAllQuestionpaperSubject(String course,String semester) async {
  http.Response response;
  response = await http.post(
    Uri.parse(Api.getQuestionpaperSubject),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    encoding: Encoding.getByName('utf-8'),
      body: {
        "course": course,
        "semester":semester
        },
  );
  List data;
  if (response.statusCode == 200) {
    data = json.decode(response.body);
    return data.map((e) => QuestionpaperSpecificSubject.fromJson(e)).toList();
    // Padhlo padhlo = Padhlo.fromJson(json.decode(response.body));
    // return padhlo;
  } else {
    return [];
  }
}

  static Future<List<QuestionpaperSpecificYears>> getAllQuestionpaperYear(String course,String semester,String subject) async {
  http.Response response;
  response = await http.post(
    Uri.parse(Api.getQuestionpaperYears),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    encoding: Encoding.getByName('utf-8'),
      body: {
        "course": course,
        "semester":semester,
        "subject" : subject
        },
  );
  List data;
  if (response.statusCode == 200) {
    data = json.decode(response.body);
    return data.map((e) => QuestionpaperSpecificYears.fromJson(e)).toList();
  } else {
    return [];
  }
}

  static Future<bool> getServerStatus() async {
  http.Response response;
  response = await http.get(
    Uri.parse(Api.getServerStatus),
  );
  if (json.decode(response.body) == true) {
    return true;
  } else {
    return false;
  }
}

}
