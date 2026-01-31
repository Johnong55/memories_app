enum Environment { dev, staging, prod }

abstract class BaseConfig {
  String get apiBaseUrl;
  bool get enableLogging;
}

class DevConfig implements BaseConfig {
  @override
  String get apiBaseUrl => "http://10.0.2.2:3000/api/v1"; // 10.0.2.2 for Android Emulator
  @override
  bool get enableLogging => true;
}

class StagingConfig implements BaseConfig {
  @override
  String get apiBaseUrl => "https://staging-api.momenttracker.com/api/v1";
  @override
  bool get enableLogging => true;
}

class ProdConfig implements BaseConfig {
  @override
  String get apiBaseUrl => "https://api.momenttracker.com/api/v1";
  @override
  bool get enableLogging => false;
}
