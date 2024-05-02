import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile/config.dart';
import 'package:mobile/model/car_model.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/services/shared_service.dart';

import 'api_service.dart';

class CarsService {
  static var client = http.Client();

  static Future<List<Car>> getAll() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
    };

    var url = Uri.https(Config.apiURL, Config.getCarsAPI);

    var response = await http.get(url);
    
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return carsFromJson(data['cars']['car']);
    }
    return [];
  }

  static Future<Car?> getDetail(String carId) async {

       Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
    };

    var url = Uri.https(Config.apiURL, '${Config.getCarsAPI}/$carId');

    var response = await http.get(url);
    
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //print(data['car']);
      return Car.fromJson(data['car']); //carsFromJson(data['data']['cars']);
    }
    return null;
  }

  static Future<bool?> NewCar(Car model) async {
    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
    var mySalon = await SalonsService.isSalon();
    var url = Uri.https(Config.apiURL, Config.getCarsAPI);
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    Map<String, dynamic> remain = {'salonId': mySalon};
    var param = model.tojson();
    var request = http.MultipartRequest("POST", url);
    request.headers.addAll(requestHeaders);
    param.entries.forEach((element) {
      if (element.key !='images' && element.value!=null && element.value!="" && element.value!='car_id')
      {
        try {
          request.fields['${element.key}'] = element.value;
        } catch (exception) {
          remain['${element.key}'] = element.value;
        }
      }
    });
    http.patch(url,headers: requestHeaders, body: jsonEncode(remain));
    if (model.image !=null)
    {
      model.image?.forEach((element) async {
        request.files.add(
            await http.MultipartFile.fromPath("image", element)
        );
      },);
    }
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var data = jsonDecode(responseString);
    if (data['status'] == 'success') return true;
    return false;
  }

  static Future<bool?> EditCar(Car model, String id) async {
    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
    var mySalon = await SalonsService.isSalon();
    var url = Uri.https(Config.apiURL, '${Config.getCarsAPI}/$id');
    print(url.toString());
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };
    Map<String, dynamic> remain = {'salonId': mySalon};
    var param = model.tojson();
    print(param);
    var request = http.MultipartRequest("PATCH", url);
    request.headers.addAll(requestHeaders);
    request.fields['salonId'] = mySalon;
    param.entries.forEach((element) {
      if (element.key !='images' && element.value!=null && element.value!="" && element.value!='car_id')
        {
          try {
            request.fields['${element.key}'] = element.value;
          } catch (exception) {
            remain['${element.key}'] = element.value;
          }
        }
    });
    http.patch(url,headers: requestHeaders, body: jsonEncode(remain));
    if (model.image !=null)
    {
      model.image?.forEach((element) async {
        request.files.add(
            await http.MultipartFile.fromPath("image", element)
        );
      },);
    }
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var data = jsonDecode(responseString);
    if (data['status'] == 'success') return true;
    return false;
  }
}