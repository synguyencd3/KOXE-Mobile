import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/config.dart';
import 'package:mobile/model/appointment_model.dart';
import 'package:mobile/services/shared_service.dart';

class AppointmentService{
  static var client = http.Client();

  static Future<List<AppointmentModel>> getAll() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };

    var url = Uri.http(Config.apiURL, Config.getAppointmentsAPI);

    var response = await http.post(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //print(data);
      return appointmentsFromJson(data['appointments']);
    }
    print('error');
    return [];
  }

  static Future<bool> createAppointment(AppointmentModel appointment) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };

    var url = Uri.http(Config.apiURL, Config.createAppointmentAPI);

    var response = await http.post(url, headers: requestHeaders, body: jsonEncode(appointment.toJson()));
    var data = jsonDecode(response.body);
    return data['status']=='success';
    }
}