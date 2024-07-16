
import 'dart:convert';
import 'dart:io';
import 'package:mobile/services/shared_service.dart';
import '../config.dart';
import '../model/maintaince_model.dart';
import 'api_service.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/services/salon_service.dart';

class MaintainceService{
  Future<List<MaintainceModel>> getAllMaintainces() async {
    //var LoginInfo = await SharedService.loginDetails();
    String salonId = await SalonsService.isSalon();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
     // HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, '${Config.getAllMaintaincesAPI}/$salonId');
    var response = await http.get(url, headers: requestHeaders);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return maintainceFromJson(data['maintenance']);
    }
    return [];
  }
  static Future<List<MaintainceModel>> getAllMaintaincesSearch(String name) async {
    //var LoginInfo = await SharedService.loginDetails();
    String salonId = await SalonsService.isSalon();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      // HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };
    Map<String, String> queryParam = {
      'q': name
    };
    var url = Uri.https(Config.apiURL, '${Config.getAllMaintaincesAPI}/$salonId', queryParam);
    var response = await http.get(url, headers: requestHeaders);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return maintainceFromJson(data['maintenance']);
    }
    return [];
  }

  Future<bool> addMaintaincePackage(MaintainceModel maintaince) async {
    var LoginInfo = await SharedService.loginDetails();
    String salonId = await SalonsService.isSalon();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.maintainceAPI);
    var response = await http.post(url, headers: requestHeaders, body: jsonEncode(maintaince.toJson()));
   return response.statusCode == 201;
  }

  Future<bool> deleteMaintaincePackage(String id) async {
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, '${Config.maintainceAPI}/$id');
    var response = await http.delete(url, headers: requestHeaders);
    return response.statusCode == 200;
  }

  Future<bool> updateMaintaincePackage(MaintainceModel maintaince) async {
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, '${Config.maintainceAPI}/${maintaince.id}');
    var response = await http.patch(url, headers: requestHeaders, body: jsonEncode(maintaince.toJson()));
    return response.statusCode == 200;
  }

}