class AppConstants {
  // App Info
  static const String appName = 'Zermii RTI';
  static const String appVersion = '1.0.0';

  // User Types
  static const String userTypeCustomer = 'customer';
  static const String userTypeAgent = 'agent';
  static const String userTypeDesigner = 'designer';
  static const String userTypeVendor = 'vendor';
  static const String userTypeDelivery = 'delivery';
  static const String userTypeAdmin = 'admin';

  // Storage Keys
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUserType = 'user_type';
  static const String keyUserId = 'user_id';
  static const String keyUserToken = 'user_token';
  static const String keyUserProfile = 'user_profile';

  // API Endpoints (Add your actual endpoints)
  static const String baseUrl = 'https://api.rtiapp.com/';
  static const String apiVersion = 'v1';

  // Timeouts
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;

  // Pagination
  static const int pageSize = 20;

  // Map
  static const double defaultLatitude = 28.7041;
  static const double defaultLongitude = 77.1025;
  static const double defaultZoom = 14.0;

  // OTP
  static const int otpLength = 6;
  static const int otpResendTimeout = 60;

  // File Upload
  static const int maxImageSize = 5 * 1024 * 1024; // 5 MB
  static const int maxVideoSize = 50 * 1024 * 1024; // 50 MB
  static const int maxDocumentSize = 10 * 1024 * 1024; // 10 MB

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 20;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
}
