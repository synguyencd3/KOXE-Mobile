import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile/model/process_model.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/services/shared_service.dart';

import '../config.dart';

class ProcessService {
  static var client = http.Client();

  static Future<List<process>> getAll() async {
    await APIService.refreshToken();
    String mySalon = await SalonsService.isSalon();
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.getProcess);

    var requestBody = {
      'salonId': mySalon
    };

    //if (id != null ) requestBody['processId'] = id;
    var response = await http.post(url, body: requestBody);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return processFromJson(data['data']);
    }
    return [];
  }

  static Future<process?> get(String? id) async {
    await APIService.refreshToken();
    String mySalon = await SalonsService.isSalon();
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.getProcess);

    var requestBody = {
      'salonId': mySalon,
      'processId': id
    };

    print("id ${id}");
    print("salon $mySalon");

    var response = await http.post(url,headers: requestHeaders, body: requestBody);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return process.fromJson(data['data']);
    }
    return null;
  }

  static Future<bool?> changeProcess(process model,String id) async {
    await UpdateProcessName(model,id);
    await UpdateProcessDocument(model,id );
    return true;
  }

  static Future<bool?> UpdateProcessName(process model, String id) async {
    await APIService.refreshToken();

    String mySalon = await SalonsService.isSalon();
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      // 'Accept': '*/*',
      // 'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.updateProcessName);
    var reqBody = model.toJson();
    reqBody['salonId'] = mySalon;
    reqBody['processId'] = id;
    print('resuest: '+ jsonEncode(reqBody));
    var response = await http.patch(url,headers: requestHeaders, body: jsonEncode(reqBody));
    var responseData = jsonDecode(response.body);
    print('response:' + response.body);
    if (responseData['status'] == 'success') {
      return true;
    }
    return false;
  }

  static Future<bool?> UpdateProcessDocument(process model,id) async {
    await APIService.refreshToken();

    String mySalon = await SalonsService.isSalon();
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      // 'Accept': '*/*',
      // 'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.updateProcessDoc);
    var reqBody = model.toJson();
    reqBody['salonId'] = mySalon;
    reqBody['period'] = id;
    print('resuest: '+ jsonEncode(reqBody));
    var response = await http.patch(url,headers: requestHeaders, body: jsonEncode(reqBody));
    var responseData = jsonDecode(response.body);
    print('response:' + response.body);
    if (responseData['status'] == 'success') {
      return true;
    }
    return false;
  }

  static Future<bool?> NewProcess(process model) async {
    await APIService.refreshToken();

    String mySalon = await SalonsService.isSalon();
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
     // 'Accept': '*/*',
     // 'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.newProcess);
    var reqBody = model.toJson();
    reqBody['salonId'] = mySalon;
    print('resuest: '+ jsonEncode(reqBody));
    var response = await http.post(url,headers: requestHeaders, body: jsonEncode(reqBody));
    var responseData = jsonDecode(response.body);
    print('response:' + response.body);
    if (responseData['status'] == 'success') {
      return true;
    }
    return false;
  }

  static Future<bool?> DeleteProcess(String id) async {
    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
    String mySalon = await SalonsService.isSalon();
    Map<String, String> requestHeaders = {
      // 'Content-Type': 'application/json',
      // 'Accept': '*/*',
      // 'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.deleteProcess);

    var response = await http.delete(url, headers: requestHeaders, body: {
      'salonId' : mySalon,
      'processId' : id
    });
    var data = jsonDecode(response.body);
    print(data);
    if (data['status'] == 'success') return true;
    return false;
  }

  static Future<bool?> updateDetails(String carId, String phone, List<String> details) async {
    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
    String mySalon = await SalonsService.isSalon();
    Map<String, String> requestHeaders = {
      // 'Content-Type': 'application/json',
      // 'Accept': '*/*',
      // 'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.checkDetailProcess);
    print(jsonEncode(details));
    var response = await http.post(url, headers: requestHeaders, body: {
      'salonId' : mySalon,
      'phone': phone,
      'carId': carId,
      'details': details.join(",")
    });
    print(response.body);
    var data = jsonDecode(response.body);
    if (data['status'] == 'success') return true;
    return false;
  }

  static Future<bool?> updateProcess(String carId, String phone, String periodId) async {
    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
    String mySalon = await SalonsService.isSalon();
    Map<String, String> requestHeaders = {

      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.updatePeriodProcess);
    var body = { 'salonId' : mySalon,
      'phone': phone,
      'carId': carId,
      'newPeriod': periodId};
    print(body);
    var response = await http.patch(url, headers: requestHeaders, body: body
    );
    var data = jsonDecode(response.body);
    if (data['status'] == 'success') return true;
    return false;
  }

  static Future<bool?> done(String invoiceId) async {
    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
    String mySalon = await SalonsService.isSalon();
    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.doneInvoiceCar);
    var response = await http.patch(url, headers: requestHeaders, body: {
      'salonId' : mySalon,
      'invoiceId' : invoiceId
    });
    print(response.body);
    var data = jsonDecode(response.body);
    if (data['status'] == 'success') return true;
    return false;
  }
}