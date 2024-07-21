import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/config.dart';
import 'package:mobile/model/process_model.dart';
import 'package:mobile/model/transaction_model.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/shared_service.dart';
import 'package:mobile/model/transaction_revenue_model.dart';

class TransactionService {
  static var client = http.Client();

  static Future<TransactionRevenueModel> getTransactions() async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    var url = Uri.https(Config.apiURL, Config.transactionsAPI);
    var response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //print(data);
      return TransactionRevenueModel.fromJson(data['transaction']);
    }
    print('error');
    return TransactionRevenueModel();
  }

  static Future<bool> updateCheckedTransaction(
      String transactionId, List<dynamic> checked) async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    var url = Uri.https(
        Config.apiURL, Config.transactionsAPI + '/$transactionId' + '/details');
    var response = await http.patch(url,
        headers: requestHeaders, body: jsonEncode({'checked': checked}));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<TransactionModel> getTransactionDetail(
      String transactionId) async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    var url =
        Uri.https(Config.apiURL, Config.transactionsAPI + '/$transactionId');
    var response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return TransactionModel.fromJson(data['transaction']);
    }
    return TransactionModel();
  }

  static Future<bool> updateTransactionStatus(
      String transactionId, String status) async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    var url =
        Uri.https(Config.apiURL, Config.transactionsAPI + '/$transactionId');
    var response = await http.put(url,
        headers: requestHeaders, body: jsonEncode({'status': status}));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<bool> updateTransactionCommissionAmount(
      String transactionId, List<dynamic> checked) async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    var url = Uri.https(
        Config.apiURL, Config.transactionsAPI + '/$transactionId' + '/details');
    var response = await http.patch(url,
        headers: requestHeaders, body: jsonEncode({'checked': checked}));
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  static Future<int> updateNextStage(
      String transactionId, int commission, int rating) async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    var url = Uri.https(
        Config.apiURL, Config.transactionsAPI + '/${transactionId}' + '/next');
    var response = await http.patch(url,
        headers: requestHeaders,
        body: jsonEncode({'commission': commission, 'rating': rating}));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        return 1;
      } else if (data['status'] == 'completed') {
        return 2;
      } else {
        return 0;
      }
    }
    return 0;
  }

  static Future<bool> deleteTransaction(String transactionId) async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    var url =
        Uri.https(Config.apiURL, Config.transactionsAPI + '/$transactionId');
    var response = await http.delete(url, headers: requestHeaders);
    return response.statusCode == 200;
  }
 static Future<process> getProcessDetail(String id) async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };
    var url = Uri.https(Config.apiURL, '/process' + '/$id');
    var response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return process.fromJson(data['process']);
    }
    return process();
 }
}
