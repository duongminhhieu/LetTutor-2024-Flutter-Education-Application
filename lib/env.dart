enum Environment { dev, test, staging, prod }


abstract class AppEnvironment {
  static late String baseApiUrl;
  static late String title;
  static late Environment _environment;
  static Environment get environment => _environment;

  static setupEnv(Environment env ){
      _environment = env;
      switch(env){
        case Environment.dev:
          baseApiUrl = "https://sandbox.api.lettutor.com/";
          title = "Dev";
          break;
        case Environment.test:
          baseApiUrl = "https://sandbox.api.lettutor.com/";
          title = "Test";
          break;
        case Environment.staging:
          baseApiUrl = "https://sandbox.api.lettutor.com/";
          title = "Staging";
          break;
        case Environment.prod:
          baseApiUrl = "https://sandbox.api.lettutor.com/";
          title = "Prod";
          break;
      }
  }
}