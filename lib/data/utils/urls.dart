class Urls{
  static const String _baseUrl = 'http://206.189.138.45:8052';
  static String get baseUrl => _baseUrl;
  static const String login = '$_baseUrl/user/login';
  static const String registration = '$_baseUrl/user/register';
  static const String createTask = '$_baseUrl/task/create-task';
  static const String getTask = '$_baseUrl/task/get-all-task';
  static const String userProfile = '$_baseUrl/user/update-profile';
  static String deleteTask(String taskId) {
    return '$_baseUrl/task/delete-task/$taskId';
  }

}