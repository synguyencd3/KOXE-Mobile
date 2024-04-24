class Config {
  static const String appName = "Salon oto";
  static const String apiURL = "192.168.1.31:5000";
  static const String loginAPI = "auth/login";
  static const String registerAPI = "auth/register";
  static const String facebookAPI = "auth/facebook-mobile";
  static const String facebookCallback = "auth/facebook/callback";
  static const String googleCallback = "auth/google/callback";
  static const String userprofileAPI = "/users/profile";
  static const String getAllPackageAPI = "/packages";
  static const String getCarsAPI = "/cars";


  //Salon
  static const String SalonsAPI = "/salons";
  static const String getIsSalonAPI = "salons/salonId";
  static const String sendInvite = "salons/invite";
  static const String acceptInviteAPI = "salons/verifyInviteUser";
  static const String mySalon = "salons/my-salon";
  static const String getEmployees = "salons/user";
  static const String Permission = "/salons/permission";

  //Appointment
  static const String getAppointmentsAPI = "/appointment/get-appoint-user";
  static const String createAppointmentAPI = "/appointment/create-appointment";
  static const String refreshToken = "auth/refresh";
  static const String getSalonAppointmentsApi = "/appointment/get-appoint-admin";
  static const String updateSalonAppointmentApi = "/appointment/update-one-admin";

  //Payment
  static const String VNPayAPI = "/payment/create_payment_url";
  static const String ZaloPayAPI = "/payment/createOrder";

  //Purchase
  static const String Purchase = "/purchase";

  //News API
  static const String newsURL = 'newsapi.org';
  static const String newsAPi = '/v2/everything';
  static const String apiKey = 'b019956a13da4697841c13223270901f';
  static const String news = "https://crawl-data-pink.vercel.app/articles";

  //Warranty
  static const String warranty  = "/warranty";
  static const String createWarranty = '/warranty/create';
  static const String updateWarranty = '/warranty/update';
  static const String deleteWarranty = '/warranty/delete';


  //Google API
  static const String client_id =
      '146451497096-20opkm9vb1m2gtjq1pt203jq23mvi6tc.apps.googleusercontent.com';
  static const String client_secret = "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";
  static const String google_api_key =
      "AIzaSyBMl0xRys9OM2P3I-1WCzhmcBH4tP7mL3w";
  static const String geocoding_api = "AIzaSyACOwKyJN5nUGEgXfli64bUMCuTcZPEY4A";

  //Web url
  static const String webURL = "http://localhost:3000";
  static const String webVNPayCallback = '/payment/vnpay';

  //KeyMap

  static const SalonKeyMap =
      "f1"; //key map phải có trong purchase để có thể sử dụng quản lí salon

//Chap API
  static const String getChatsAPI = "/messages";
  static const String getAllChatUsersAPI = "/messages/chatting-users";
  static const String sendMessageAPI = "/messages/send";

  //Notification API
static const String getNotificationAPI = "/notification/get-notification-user";
static const String markAsReadAPI = "/notification/read-notification-user";
static const String getNotificationSalonAPI = "/notification/get-notification-admin";
static const String markAsReadSalonAPI = "/notification/read-notification-admin";

//Zego 
static const int zegoAppID = 52749659;
static const String zegoAppSign = '686508249a354437ee8f22ad801b016981d3d62206cff615804d23559dc1eb99';
}
