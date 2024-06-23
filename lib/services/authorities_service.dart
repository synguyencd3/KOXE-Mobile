import 'dart:convert';
import 'dart:io';

import 'package:mobile/model/authority_model.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/services/shared_service.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import 'api_service.dart';

class AuthorityService {
  static var client = http.Client();

  static Future<List<authority>> getRoles() async {
    await APIService.refreshToken();
    String mySalon = await SalonsService.isSalon();
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.roleApi);
    print(url);
    var response = await http.get(url, headers: requestHeaders);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //print(data);
      var authorities = authoritiesFromJson(data['data']);
      return authorities;
    }
    return [];
  }

  static Future<bool> setPermission(List<String> permissions, String id, String name) async {
    await APIService.refreshToken();
    String mySalon = await SalonsService.isSalon();
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.roleApi);

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salonId'] = mySalon;
    data['permissions'] = permissions.join(",");
    data['name'] = name;
    data['id'] = id;

    print(data);
    var response = await http.patch(url, headers: requestHeaders, body: data);
    var resBody = jsonDecode(response.body);
    print(resBody);
    if (resBody['status'] == 'success') return true;
    return false;
  }

  static Future<bool> newRole(List<String> permissions, String name) async {
    await APIService.refreshToken();
    String mySalon = await SalonsService.isSalon();
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.roleApi);

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salonId'] = mySalon;
    data['permissions'] = permissions.join(",");
    data['name'] = name;

    print(data);
    var response = await http.post(url, headers: requestHeaders, body: data);
    var resBody = jsonDecode(response.body);
    print(resBody);
    if (resBody['status'] == 'success') return true;
    return false;
  }


  static Future<bool> deleteRole(String id) async {
    await APIService.refreshToken();
    String mySalon = await SalonsService.isSalon();
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salonId'] = mySalon;

    var url = Uri.https(Config.apiURL, "${Config.roleApi}/$id");
    var response = await http.delete(url, headers: requestHeaders, body: data);
    var resBody = jsonDecode(response.body);
    print(resBody);
    if (resBody['status'] == 'success') return true;
    return false;
  }

  static Future<bool> assingRole(String roleid, String staffId) async {
    await APIService.refreshToken();
    String mySalon = await SalonsService.isSalon();
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salonId'] = mySalon;
    data['roleId'] = roleid;
    data['employeeId'] = staffId;

    var url = Uri.https(Config.apiURL, Config.assignApi);
    var response = await http.post(url, headers: requestHeaders, body: data);
    var resBody = jsonDecode(response.body);
    print(resBody);
    if (resBody['status'] == 'success') return true;
    return false;
  }
}