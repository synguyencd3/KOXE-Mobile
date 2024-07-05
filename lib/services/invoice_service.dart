
import 'dart:convert';
import 'dart:io';
import 'package:mobile/model/invoice_model.dart';
import 'package:mobile/services/shared_service.dart';
import '../config.dart';
import 'package:http/http.dart' as http;


class InvoiceService{
  Future<List<InvoiceModel>> getAllInvoices() async {
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.getInvoiceAPI);
    var response = await http.get(url, headers: requestHeaders);
    //print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['invoices'] == '[]')
        return [];
      return invoiceFromJson(data['invoices']);
    }
    return [];
  }

  Future<bool> addInvoice(InvoiceModel invoice) async {
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };
    var url = Uri.https(Config.apiURL, Config.invoiceAPI);
    var response = await http.post(url, headers: requestHeaders, body: jsonEncode(invoice.toJson()));
    print(response.body);
    return response.statusCode == 201;
  }
  static Future<bool> deleteInvoice(String id) async {
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };
    var url = Uri.https(Config.apiURL, Config.invoiceAPI + '/$id');
    var response = await http.delete(url, headers: requestHeaders);
    return response.statusCode == 200;
  }
  static Future<List<InvoiceModel>> getInvoiceByLicense(String licensePlate) async {
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, '${Config.getInvoiceLicenseAPI}/$licensePlate');
    var response = await http.get(url, headers: requestHeaders);
    //print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return invoiceFromJson(data['invoices']);
    }
    return [];
  }
}