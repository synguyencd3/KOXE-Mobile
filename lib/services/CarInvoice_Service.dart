import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile/model/CarInvoice_request.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/services/shared_service.dart';

import '../config.dart';
import '../model/CarInvoice_response.dart';
import 'api_service.dart';

class CarInvoiceService {
  static var client = http.Client();

  static Future<List<CarInvoice>> getAll(String? id) async {
    await APIService.refreshToken();
    String mySalon = await SalonsService.isSalon();
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      // 'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };
    var url = Uri.https(Config.apiURL, Config.getInvoiceCar);

    var requestBody =  {
    'salonId': mySalon
    };

    if (id!= null ) {
      requestBody['processId'] = id;
    }

    var response = await http.post(url,headers: requestHeaders, body: requestBody);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return carInvoicesFromJson(data['invoices']);
    }
    return [];
  }

  static Future<List<CarInvoice>> getAllCustomer() async {
    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      // 'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };
    var url = Uri.https(Config.apiURL, Config.getInvoiceCarCustomer);


    var response = await http.post(url,headers: requestHeaders);
    //print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return carInvoicesFromJson(data['invoices']);
    }
    return [];
  }

  static Future<bool?> newInvoice(InvoiceRequest model) async {
    await APIService.refreshToken();

    String mySalon = await SalonsService.isSalon();
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.createInvoiceCar);
    var reqBody = model.toJson();
    reqBody['salonId'] = mySalon;
    print(jsonEncode(reqBody));
    var response = await http.post(url,headers: requestHeaders, body: jsonEncode(reqBody));
    print(response.body);
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == 'success') {
      return true;
    }
    return false;
  }

  // static Future<bool?> newInvoice(InvoiceRequest model) async {
  //   await APIService.refreshToken();
  //
  //   String mySalon = await SalonsService.isSalon();
  //   var LoginInfo = await SharedService.loginDetails();
  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json',
  //     'Accept': '*/*',
  //     'Access-Control-Allow-Origin': "*",
  //     HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
  //   };
  //
  //   var url = Uri.https(Config.apiURL, Config.createInvoiceCar);
  //   var reqBody = model.toJson();
  //   reqBody['salonId'] = mySalon;
  //   print(jsonEncode(reqBody));
  //   var response = await http.post(url,headers: requestHeaders, body: jsonEncode(reqBody));
  //   print(response.body);
  //   var responseData = jsonDecode(response.body);
  //   if (responseData['status'] == 'success') {
  //     return true;
  //   }
  //   return false;
  // }
}