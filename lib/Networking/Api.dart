class Api{
  static String domain = 'https://padhloapp.herokuapp.com' ; 
  //static String domain = 'http://192.168.0.107:3000';

  // get notes data 
  static String getAllData = domain + '/alldata';
  static String getAllCourse = domain + '/courses';
  static String getSemester = domain + '/semesters';
  static String getSubject = domain + '/subjects';
  static String getUnit = domain + '/units';
  static String getTopic = domain + '/topics';

  // get question paper data 
  static String getQuestionpaperCourse = domain + '/questionPaperCourses';
  static String getQuestionpaperSemester = domain +'/questionPaperSemesters';
  static String getQuestionpaperSubject = domain +'/questionPaperSubjects';
  static String getQuestionpaperYears = domain + '/questionPaperYears';
}