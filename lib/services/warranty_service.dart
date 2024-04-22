import 'dart:convert';
import 'dart:io';

import 'package:mobile/model/warranty_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/services/shared_service.dart';
import '../config.dart';
import 'api_service.dart';

class WarrantyService {
  static var client = http.Client();

  static Future<List<Warranty>> getAll() async {
    await APIService.refreshToken();
    String mySalon = await SalonsService.isSalon();
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.http(Config.apiURL, Config.warranty);

    var response = await http.post(url, body: {
    'salonId': mySalon
    });
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return warrantiesFromJson(data['warranties']);
    }
    return [];
  }

  static Future<bool?> NewWarranty(Warranty model) async {
    await APIService.refreshToken();

    String mySalon = await SalonsService.isSalon();
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.http(Config.apiURL, Config.createwarranty);
    var reqBody = model.toJson();
    reqBody['salonId'] = mySalon;
    print(jsonEncode(reqBody));
    var response = await http.post(url,headers: requestHeaders, body: jsonEncode(reqBody));
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == 'success') {
      return true;
    }
    return false;
  }

}