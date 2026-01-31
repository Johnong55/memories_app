import 'environment.dart';

class AppConfig {
  static late BaseConfig shared;
  // static late Environment _env;

  static void init(Environment env) {
    // _env = env;
    switch (env) {
      case Environment.dev:
        shared = DevConfig();
        break;
      case Environment.staging:
        shared = StagingConfig();
        break;
      case Environment.prod:
        shared = ProdConfig();
        break;
    }
  }
}
