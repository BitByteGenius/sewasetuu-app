import 'environment.dart';

/// Global application configuration and environment bootstrap settings.
class AppConfig {
  final String appName;
  final String apiBaseUrl;
  final Environment environment;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final bool enableLogging;

  static late AppConfig _instance;
  static AppConfig get instance => _instance;

  AppConfig._({
    required this.appName,
    required this.apiBaseUrl,
    required this.environment,
    required this.connectTimeout,
    required this.receiveTimeout,
    required this.enableLogging,
  });

  static void initialize({
    required String appName,
    required String apiBaseUrl,
    required Environment environment,
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
    bool enableLogging = true,
  }) {
    _instance = AppConfig._(
      appName: appName,
      apiBaseUrl: apiBaseUrl,
      environment: environment,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      enableLogging: enableLogging,
    );
  }

  bool get isProduction => environment == Environment.prod;
  bool get isDevelopment => environment == Environment.dev;
}
