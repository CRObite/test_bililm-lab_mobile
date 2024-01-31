class AppApiUrls{
  static String url = 'https://api.oquway.kz';
  static String mainApi = '$url/api';
  static String userLogin = '$mainApi/user-login';
  static String getMe = '$mainApi/universal-get-me';
  static String registration = '$mainApi/user-registration';
  static String recoverPassword = '$mainApi/user-recover-password';
  static String deleteUser = '$mainApi/user-delete';

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

  static String refreshToken = '$mainApi/user-refresh';
  static String getBalance = '$mainApi/user-wallet/get-balance';

  static String getRegions = '$mainApi/dictionary/regions';
  static String getCity = '$mainApi/dictionary/cities';
  static String getSchool = '$mainApi/dictionary/schools';

  static String getAllPosts = '$mainApi/post/get-all';
  static String getPostByID = '$mainApi/post/get-by-id/';

  static String getAllUniversity = '$mainApi/university/get-all';
  static String getUniversityById = '$mainApi/university/get-by-id/';

  static String getCommentsByUniversity = '$mainApi/comment/get-all-by-university/';
  static String getCommentsBySpecialization = '$mainApi/comment/get-all-by-specialization/';
  static String getCommentsByPost = '$mainApi/comment/get-all-by-post/';
  static String saveComment = '$mainApi/comment/save';

  static String getCommentsAnswersById = '$mainApi/comment-answer/get-by-id/';
  static String saveCommentAnswer = '$mainApi/comment-answer/save';

  static String getAllSpecialization = '$mainApi/specialization/get-all';
  static String getSpecializationById = '$mainApi/specialization/get-by-id/';

  static String subscription = '$mainApi/dictionary/subscriptions';
  static String setSubscriptionToUser = '$mainApi/user/subscribe/';
}