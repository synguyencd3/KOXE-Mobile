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

    var response = await http.post(url, body: {
      'salonId': mySalon
    });
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return processFromJson(data['data']);
    }
    return [];
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
    if (data['status'] == 'success') return true;
    return false;
  }
}