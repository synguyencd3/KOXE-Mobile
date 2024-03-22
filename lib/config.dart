class Config {
  static const String appName = "Salon oto";
  static const String apiURL = "192.168.1.5:5000";
  static const String loginAPI = "auth/login"; 
  static const String registerAPI = "auth/register";
  static const String facebookAPI = "auth/facebook-mobile";
  static const String facebookCallback = "auth/facebook/callback";
  static const String googleCallback = "auth/google/callback";
  static const String userprofileAPI = "/users/profile";
  static const String getAllPackageAPI = "/packages";
  static const String getCarsAPI = "/cars";
  static const String getSalonsAPI = "/salons";

  //Payment
  static const String VNPayAPI = "/payment/vnpay";
  static const String ZaloPayAPI = "/payment/createOrder";

  //News API
  static const String newsURL = 'newsapi.org';
  static const String newsAPi = '/v2/everything';
  static const String apiKey = 'b019956a13da4697841c13223270901f';

  //Google API
  static const String client_id = '146451497096-20opkm9vb1m2gtjq1pt203jq23mvi6tc.apps.googleusercontent.com';
  static const String client_secret = "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";
  static const String google_api_key = "AIzaSyBMl0xRys9OM2P3I-1WCzhmcBH4tP7mL3w";
  static const String geocoding_api = "AIzaSyACOwKyJN5nUGEgXfli64bUMCuTcZPEY4A";

}
