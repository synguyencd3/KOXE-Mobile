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
     // 'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.warranty);

    var response = await http.post(url,headers: requestHeaders, body: {
    'salonId': mySalon
    });
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return warrantiesFromJson(data['warranties']);
    }
    return [];
  }

  static Future<bool?> addMaintenance(String warrantyId, List<String?> maintenanceArray) async {
    await APIService.refreshToken();

    String mySalon = await SalonsService.isSalon();
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',

      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.addMaintencance);
    var response = await http.post(url, headers: requestHeaders, body: jsonEncode(
        {
          'warrantyId' : warrantyId,
          'maintenanceArray' : maintenanceArray
        }));
    print(response.body);
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == 'success') {
      return true;
    }
    return false;
  }

  static Future<bool?> NewWarranty(Warranty model, List<String?> maintenanceList) async {
    await APIService.refreshToken();

    String mySalon = await SalonsService.isSalon();
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.createWarranty);
    var reqBody = model.toJson();
    reqBody['salonId'] = mySalon;
    print(jsonEncode(reqBody));
    var response = await http.post(url,headers: requestHeaders, body: jsonEncode(reqBody));
    var responseData = jsonDecode(response.body);
    //if (maintenanceList.isNotEmpty) addMaintenance(responseData['warranty_id'], maintenanceList);
    if (responseData['status'] == 'success') {
      return true;
    }
    return false;
  }

  static Future<bool?> updateWarranty(Warranty model, String id, List<String?> maintenanceArray) async {
    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
    String mySalon = await SalonsService.isSalon();
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.updateWarranty);
    var modelJson = model.toJson();
    modelJson['warranty_id'] = id;
    Map<String, dynamic> reqBody ={
    "salonId": mySalon,
    "newWarranty" : modelJson
  };
   // print(jsonEncode(reqBody));
    var temp = jsonEncode(reqBody);
    print(temp.toString());
    var response = await http.patch(url, headers: requestHeaders, body: jsonEncode(reqBody));
    var responseData = jsonDecode(response.body);
    print(responseData);
    if (maintenanceArray.isNotEmpty) addMaintenance(id, maintenanceArray);
    if (responseData['status'] == 'success') {
      return true;
    }
    return false;
  }

  static Future<bool?> DeleteWarranty(String id) async {
    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
    String mySalon = await SalonsService.isSalon();
    Map<String, String> requestHeaders = {
     // 'Content-Type': 'application/json',
     // 'Accept': '*/*',
     // 'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.deleteWarranty);

    var response = await http.delete(url, headers: requestHeaders, body: {
      'salonId' : mySalon,
      'warrantyId' : id
    });
    var data = jsonDecode(response.body);
    if (data['status'] == 'success') return true;
    return false;
  }

  static Future<bool?> pushWarranty(String warrantyId, String carId) async {
    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
    String mySalon = await SalonsService.isSalon();
    Map<String, String> requestHeaders = {
      // 'Content-Type': 'application/json',
      // 'Accept': '*/*',
      // 'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.pushWarranty);

    var response = await http.post(url, headers: requestHeaders, body: {
      'salonId' : mySalon,
      'warrantyId' : warrantyId,
      'carId' : carId
    });
    var data = jsonDecode(response.body);
    if (data['status'] == 'success') return true;
    return false;
  }
}