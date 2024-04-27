
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

    var url = Uri.http(Config.apiURL, Config.invoiceAPI);
    var response = await http.get(url, headers: requestHeaders);
    print(response.body);
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
    var url = Uri.http(Config.apiURL, Config.invoiceAPI);
    var response = await http.post(url, headers: requestHeaders, body: jsonEncode(invoice.toJson()));
    print(response.body);
    return response.statusCode == 201;
  }
}