import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/config.dart';

class PaymentService {
   static var client = http.Client();

   static Future<String?> getVNPayURL() async {
      var url = Uri.http(Config.apiURL, Config.VNPayAPI);


    var response = await client.post(url);

     String VnPayURL = jsonDecode(response.body)['vnpUrl'];
      return VnPayURL;
   }

   static Future<String?> getZaloPayURL() async {
     var url = Uri.http(Config.apiURL, Config.ZaloPayAPI);


    var response = await client.post(url);

     String ZaloPayURL = jsonDecode(response.body)['data']['order_url'];
      return ZaloPayURL;
   }
}