import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile/config.dart';
import 'package:mobile/model/car_model.dart';
import 'package:mobile/model/salon_model.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/shared_service.dart';

class SalonsService {
  static var client = http.Client();

  static Future<List<Salon>> getAll() async {
    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
       HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.http(Config.apiURL, Config.SalonsAPI);

    var response = await http.get(url, headers: requestHeaders);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return salonsFromJson(data['salons']['salons']);
    }
    return [];
  }

  static Future<List<Car>?> getDetail(String salonId) async {
    var LoginInfo = await SharedService.loginDetails();
       Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.http(Config.apiURL, '${Config.SalonsAPI}/$salonId');

    var response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //print(data);
      return carsFromJson(data['salon']['cars']);
    }
    return null;
  }

  static Future<Salon?> getMySalon() async {
    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
     Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.http(Config.apiURL, Config.mySalon);

    var response = await http.get(url, headers: requestHeaders);
     if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      var salon = Salon.fromJson(data['salon']);
      return salon;
    }
    return null;
  }

  static Future<bool?> NewSalon(Salon model) async {
    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
    var url = Uri.http(Config.apiURL, Config.SalonsAPI);
     Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var param = model.toJson();

    var request = http.MultipartRequest("POST", url);
    request.headers.addAll(requestHeaders);
    request.fields['name'] = param['name'];
    request.fields['addess'] = param['address'];
    request.fields['email'] = param['email'];
    request.fields['phoneNumber'] = param['phoneNumber'];
    request.fields['introductionMarkdown'] = param['introductionMarkdown'];
    
    if (model.banner !=null)
    {
      var image = await http.MultipartFile.fromPath("image", model.banner!.first);
      request.files.add(image);
      model.banner?.forEach((element) async {
        request.files.add(
          await http.MultipartFile.fromPath("banner", element)
        );
      },);
    }
    var response = await request.send();

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    return false;
  }
  static Future<String> isSalon()  async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    var url = Uri.http(Config.apiURL, Config.getIsSalonAPI);

    var response = await http.get(url, headers: requestHeaders);
    var responseData = jsonDecode(response.body);

    if (responseData['status'] == 'success') {
      if (responseData['salonId'] == null){
        return '';
      } else {
        return responseData['salonId'];
      }
    }
    else
    {
      return '';
    }
  }
}