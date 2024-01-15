class AppApiUrls{
  static String url = 'https://api.oquway.kz';
  static String mainApi = '$url/api';
  static String userLogin = '$mainApi/user-login';
  static String getMe = '$mainApi/universal-get-me';

  static String getAllSub = '$mainApi/ent-test/subjects';
  static String getAllSubInMSS = '$mainApi/ent-test/subjects-in-mss';
  static String getAllModoClass = '$mainApi/school-test/school-classes';


  static String generateEntTest = '$mainApi/ent-test/generate';
  static String endEntTest = '$mainApi/ent-test/end';
  static String saveAnswerEntTest = '$mainApi/ent-test/answer';
  static String deleteAnswerEntTest = '$mainApi/ent-test/answer';
  static String getLastEntTest = '$mainApi/ent-test/get-last';
  static String getAllByUser = '$mainApi/ent-test/get-all-by-user';
  static String getStatisticByUser = '$mainApi/ent-test/get-statistic-by-user';
  static String getTestMistakes = '$mainApi/ent-test/get-mistakes/';


  static String generateSchoolTest = '$mainApi/school-test/generate';
  static String endSchoolTest = '$mainApi/school-test/end';
  static String saveAnswerSchoolTest = '$mainApi/school-test/answer';
  static String deleteAnswerSchoolTest = '$mainApi/school-test/answer';
  static String getLastSchoolTest = '$mainApi/school-test/get-last';

  static String getMedia = '$mainApi/media/get-content/';
  static String getResult = '$mainApi/ent-test/result';
  static String getSchoolResult = '$mainApi/school-test/result';

  static String refreshToken = '$mainApi/refresh-token';

}