import 'dart:convert';
import 'dart:io';
import 'package:mobile/model/salon_group_model.dart';
import 'package:mobile/services/shared_service.dart';
import '../config.dart';
import '../model/maintaince_model.dart';
import 'package:http/http.dart' as http;

class SalonGroupService {
  static Future<List<SalonGroupModel>> getAllGroups() async {
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.salonGroupAPI);
    var response = await http.get(url, headers: requestHeaders);
    //print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return salonGroupFromJson(data['groupSalons']);
    }
    return [];
  }

  static Future<bool> createGroup(SalonGroupModel group) async {
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };
    var url = Uri.https(Config.apiURL, Config.salonGroupAPI);
    var response =
        await http.post(url, headers: requestHeaders, body: jsonEncode(group));
    return response.statusCode == 201;
  }

  static Future<bool> deleteGroup(String id) async {
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };
    var url = Uri.https(Config.apiURL, '${Config.salonGroupAPI}/$id');
    var response = await http.delete(url, headers: requestHeaders);
    return response.statusCode == 200;
  }
}
