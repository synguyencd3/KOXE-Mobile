import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/config.dart';
import 'package:mobile/model/appointment_model.dart';
import 'package:mobile/model/time_busy_model.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/shared_service.dart';

class AppointmentService {
  static var client = http.Client();

  static Future<List<AppointmentModel>> getAll() async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.getAppointmentsAPI);

    var response = await http.post(url, headers: requestHeaders);
    //print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
    //   try
    //   {
    //     return appointmentsFromJson(data['appointments']);
    //   }
    //   catch(e)
    // {
    //   print(e);
    // }
      return appointmentsFromJson(data['appointments']);
    }
    return [];
  }

  static Future<bool> createAppointment(AppointmentModel appointment) async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.createAppointmentAPI);

    var response = await http.post(url,
        headers: requestHeaders, body: jsonEncode(appointment.toJson()));
    var data = jsonDecode(response.body);
    return data['status'] == 'success';
  }

  static Future<List<AppointmentModel>> getAllSalonAppointments(
      String salonId) async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.getSalonAppointmentsApi);

    var response = await http.post(url,
        headers: requestHeaders, body: jsonEncode({'salonId': salonId}));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //print(data);
      return appointmentsFromJson(data['appointments']);
    }
    return [];
  }

  static Future<AppointmentModel> getAppointmentById(
      String salonId, String appointmentId) async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    print(appointmentId);
    var url = Uri.https(Config.apiURL, Config.getSalonAppointmentsApi);

    var response = await http.post(url,
        headers: requestHeaders,
        body: jsonEncode({'salonId': salonId, 'id': appointmentId}));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return AppointmentModel.fromJson(data['appointments'][0]);
    }
    print('error');
    return AppointmentModel(
        id: '',
        status: 0,
        salon: '',
        description: '',
        datetime: DateTime.now());
  }
  static Future<AppointmentModel> getAppointmentByIdUser(String appointmentId) async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    print(appointmentId);
    var url = Uri.https(Config.apiURL, Config.getAppointmentsAPI);

    var response = await http.post(url,
        headers: requestHeaders,
        body: jsonEncode({'id': appointmentId}));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return AppointmentModel.fromJson(data['appointments'][0]);
    }
    return AppointmentModel(
        id: '',
        status: 0,
        salon: '',
        description: '',
        datetime: DateTime.now());
  }

  static Future<bool> updateSalonAppointment(
      String salonId, String? appointmentId, int status) async {
    //status: 0 - chưa chấp nhận | status: 1 - đã được chấp nhận| status: 2 - bị salon từ chối gặp
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.updateSalonAppointmentApi);

    var response = await http.patch(url,
        headers: requestHeaders,
        body: jsonEncode(
            {'id': appointmentId, 'status': status, 'salonId': salonId}));
    var data = jsonDecode(response.body);
    return data['status'] == 'success';
  }

  static Future<List<TimeBusyModel>> getBusyCar(
      String salonId, String carId) async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.getBusyCarApi);

    var response = await http.post(url,
        headers: requestHeaders,
        body: jsonEncode({'salonId': salonId, 'carId': carId}));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return timeBusyFromJson(data['timeBusy']);
    } else {
      return [];
    }
  }

  static Future<bool> createAppointmentProcess(
      AppointmentModel appointment) async {
    print(appointment.carId);
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.createAppointmentProcessAPI);

    var response = await http.post(url,
        headers: requestHeaders, body: jsonEncode(appointment.toJson()));
    print(response.body);
    return response.statusCode == 200;
  }

  static Future<bool> updateAppointmentProcess(
      String? appointmentId, int status) async {
    //status:1 - accepted | status: 2 - rejected
    await APIService.refreshToken();
    print('test');
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.updateAppointmentAPI);

    var response = await http.patch(url,
        headers: requestHeaders,
        body: jsonEncode({'id': appointmentId, 'status': status}));
    return response.statusCode == 200;
  }
}
