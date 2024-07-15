class Config {
  static const String appName = "Salon oto";
  static const String apiURL =   "server-graduation-thesis-1.onrender.com";//"salon-gateway.onrender.com";//
  static const String loginAPI = "auth/login";
  static const String registerAPI = "auth/register";
  static const String facebookAPI = "auth/facebook-mobile";
  static const String facebookCallback = "auth/facebook/callback";
  static const String googleCallback = "auth/google/callback";
  static const String userprofileAPI = "/users/profile";
  static const String getAllPackageAPI = "/packages";

  //Car
  static const String getCarsAPI = "/cars";
  static const String getCarsOfSalonAPI = "/cars/salon";

  //Salon
  static const String SalonsAPI = "/salons";
  static const String salonCarsAPI = "/cars/salon";
  static const String getIsSalonAPI = "salons/salonId";
  static const String sendInvite = "salons/invite";
  static const String acceptInviteAPI = "salons/verifyInviteUser";
  static const String mySalon = "salons/my-salon";
  static const String getEmployees = "salons/user";
  static const String Permission = "/salons/permission";
  static const String SalonPaymentAPI = "/salon-payment";
  static const String createSalonPaymentAPI = "/salon-payment/create";
  static const String createSalonPaymentMethodAPI = "/salon-payment/create-method";
  static const String salonPaymentMethodAPI = "/salon-payment/method";
  static const String salonConfirmAPI = "/salon-payment/confirm-salon";
  static const String userConfirmAPI = "/salon-payment/confirm-user";

  //Appointment
  static const String getAppointmentsAPI = "/appointment/get-appoint-user";
  static const String createAppointmentAPI = "/appointment/create-appointment";
  static const String refreshToken = "auth/refresh";
  static const String getSalonAppointmentsApi =
      "/appointment/get-appoint-admin";
  static const String updateSalonAppointmentApi =
      "/appointment/update-one-admin";
  static const String getBusyCarApi = "/appointment/get-busy-car";
  static const String createAppointmentProcessAPI =
      "/appointment/create-appointment-process";
  static const String updateAppointmentAPI = "/appointment/response-appointment-process";

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
  static const String warranty = "/warranty";
  static const String createWarranty = '/warranty/create';
  static const String updateWarranty = '/warranty/update';
  static const String deleteWarranty = '/warranty/delete';
  static const String pushWarranty = '/warranty/push-warranty';
  static const String addMaintenance = '/warranty/add-maintenance';
  static const String removeMaintenance = '/warranty/remove-maintenance';

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
//key map phải có trong purchase để có thể sử dụng quản lí salon
  static const SalonKeyMap = "f1";
  static const CarKeyMap="f2";
  static const UserKeyMap="f3";
  static const AppointmentKeyMap = "f4";
  static const WarrantyKeyMap = "f5";
  static const MaintainKeyMap = "f6";
  static const TransactionKeyMap = "f7";
  static const AccessoryKeyMap = "f8";
  static const ProcessKeyMap = "f9";
  static const StageKeyMap = "f10";
  static const PromotionKeyMap = "f11";
  static const PaymentKeyMap = "f12";
  static const CreatePostKeyMap = "f13";
  static const StaticKeyMap = "f14";
  static const TransactionNavigatorKeyMap = "f15";
  static const ConnectionKeyMap = "f16";

//Chat API
  static const String getChatsAPI = "/messages";
  static const String getAllChatUsersAPI = "/messages/chatting-users";
  static const String sendMessageAPI = "/messages/send";
  static const String searchUserAPI = "/messages/search";

  //Notification API
  static const String getNotificationAPI =
      "/notification/get-notification-user";
  static const String markAsReadAPI = "/notification/read-notification-user";
  static const String getNotificationSalonAPI =
      "/notification/get-notification-admin";
  static const String markAsReadSalonAPI =
      "/notification/read-notification-admin";

//Zego
  static const int zegoAppID = 988759543;//52749659;
  static const String zegoAppSign = '74d217a12ea3d3f7e0414304f02815f42b6666780363cd5b499f782717cd95c9';
    // '686508249a354437ee8f22ad801b016981d3d62206cff615804d23559dc1eb99';

//statistic
  static const String statistic = "/invoice/statistics";
  static const String getTop = 'invoice/get-top';

//Maintaince API
  static const String getAllMaintaincesAPI = "maintenance/salon";
  static const String maintainceAPI = "/maintenance";

//Invoice API
  static const String invoiceAPI = "/invoice";
  static const String getInvoiceAPI = "/invoice/get-invoice-maintenance";
  static const String getInvoiceLicenseAPI = "/invoice/by-license";

// Accessory API
  static const String getSalonAccessoriesApi = "/accessory/salon";
  static const String accessoryAPI = "/accessory";

  //Process
  static const String getProcess = '/legals/process';
  static const String newProcess = '/legals/create-process';
  static const String updateProcessName = '/legals/update-process';
  static const String deleteProcess = '/legals/delete-process';
  static const String deleteProcessDoc = '/legals/delete-documents';
  static const String updateProcessDoc = '/legals/update-documents';
  static const String createProcessDoc = '/legals/create-documents';
  static const String checkDetailProcess = '/legals/check-details-user';
  static const String updatePeriodProcess = '/legals/update-period-user';

  //Car Invoice
  static const String getInvoiceCarCustomer = '/invoice/get-invoice-buy-car';
  static const String createInvoiceCar = '/invoice/create-invoice';
  static const String lookupInvoiceCar = '/invoice/lookup';
  static const String getInvoiceCar = '/invoice/get-invoice-buy-car-salon';
  static const String doneInvoiceCar = '/invoice/tick-done';

  //Post API
  static const String getPosts = "/posts/feed";
  static const String posts = "/posts";

// Connection API
  static const String connectionsAPI = "/connections";

// Transaction API
  static const String transactionsAPI = "/transactions";

//Stage API
  static const String stagesAPI = "/stages";

//Block API
  static const String blocksAPI = "/block-user";
  static const String blockedUsersAPI = "/salons/users/blocked";

// Password API
  static const String changePasswordAPI = "/auth/change-pw";
  static const String verifyPasswordAPI = "/auth/verify-forgot-pw";
  static const String renewPasswordAPI = "/auth/renew-forgot-pw";
  static const String forgotPasswordAPI = "/auth/forgot-pw";

  //Salon Group API
static const String salonGroupAPI = "/group/salon";
// Accessory Group API
static const String accessoryInvoiceAPI = "/buy-accessory";


//Promotion
static const String promotionAPI = "/promotions";
static const String salonPromotionAPI = "/promotions/salon";


//FIREBASE
static const String firebaseApiKey = "AIzaSyCbfy8s5vE9W1ZkHWzpmBgGeKypSNDg82M";
static const String firebaseAppId = "1:193303518481:android:f625498ebfb22d70f900b0";
static const String firebaseProjectId = "k20-oto";
static const String firebaseSenderId = "193303518481";


//Authority
static const String roleApi= "/salons/role";
static const String assignApi = "/salons/assign-role";
}
