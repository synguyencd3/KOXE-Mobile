import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/config.dart';
import 'package:mobile/model/notification_model.dart';
import 'package:mobile/services/shared_service.dart';
import 'package:mobile/services/api_service.dart';

class NotificationService{
  static var client = http.Client();

  static Future<List<NotificationModel>> getAllNotification() async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };

    var url = Uri.http(Config.apiURL, Config.getNotificationAPI);

    var response = await http.post(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //print(data);
      return notificationFromJson(data['notifications']);
    }
    print('error');
    return [];
  }
static Future<void> markAsRead(String id) async {
    await APIService.refreshToken();
    print(id);
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };

    var url = Uri.http(Config.apiURL, Config.markAsReadAPI);

    var response = await http.patch(url, headers: requestHeaders, body: jsonEncode({'id': id}));

    if (response.statusCode == 200) {
      print('Mark as read');
    } else {
      print('error');
    }
  }
  static Future<List<NotificationModel>> getAllNotificationSalon(String salonId) async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };

    var url = Uri.http(Config.apiURL, Config.getNotificationSalonAPI);

    var response = await http.post(url, headers: requestHeaders,  body: jsonEncode({'salonId': salonId}));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //print(data);
      return notificationFromJson(data['notifications']);
    }
    print('error');
    return [];
  }

}