class ApiEndpoints {
  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refresh = '/auth/refresh';
  static const String profile = '/auth/profile';

  // Moments
  static const String moments = '/moments';
  
  // Groups
  static const String groups = '/groups';
  static const String joinGroup = '/join'; // /groups/:id/join
  
  // Location
  static const String trackLocation = '/locations/track';
}

class StorageKeys {
  static const String token = 'auth_token';
  static const String refreshToken = 'refresh_token';
  static const String user = 'user_profile';
  static const String userId = 'user_id';
  static const String theme = 'app_theme';
}
