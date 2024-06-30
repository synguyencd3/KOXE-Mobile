import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile/config.dart';
import 'package:mobile/model/purchased_package.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/shared_service.dart';
import 'package:http_retry/http_retry.dart';

class PaymentService {
   static var client = http.Client();
//    static var client = RetryClient(
//    http.Client(), 
//    retries: 1,
//    when: (response) {
//     return response.statusCode == 401;
//    },
//    onRetry: (req, res, retryCount) {
//      if (retryCount == 0 && res?.statusCode == 401) {
//         // refresh token
//      }  
//    },
// );


   static Future<String?> getVNPayURL(String packageId) async {
    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'Accept': '*/*',
    'Access-Control-Allow-Origin': "*",
    HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };


    final Map<String, String> param = <String, String>{
    'package_id': packageId,
    'months': 1.toString()
    };

    var url = Uri.https(Config.apiURL, Config.VNPayAPI, param);


    var response = await client.post(url, headers: requestHeaders, body: jsonEncode(param));
    if (jsonDecode(response.body)['status']=="failed")
    {
      return "";
    }
    
    String VnPayURL = jsonDecode(response.body)['vnpUrl'];
    return VnPayURL;
   }

   static Future<String?> getZaloPayURL() async {
      var url = Uri.https(Config.apiURL, Config.ZaloPayAPI);


      var response = await client.post(url);

      String ZaloPayURL = jsonDecode(response.body)['data']['order_url'];
        return ZaloPayURL;
   }

   static Future<Set<String>> getPurchasedSet() async {
    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
      Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };
    var url = Uri.https(Config.apiURL, Config.Purchase);
    var response = await client.get(url, headers: requestHeaders);
    var data =jsonDecode(response.body)['purchasedPackages'];
    var set=data.map((index) =>(index['package_id']));
    print(set);
    return Set.from(set);
   }

   static Future<Set<String>> getKeySet() async {
    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
      Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };
    var url = Uri.https(Config.apiURL, Config.Purchase);
    var response = await client.get(url, headers: requestHeaders);
    var data =jsonDecode(response.body)['purchasedPackages'];
    print(response.body);
    var features=packagesFromJson(data).map((index) =>(index.features));
  
    List<String?> keyMaps = [];
    features.forEach( (i) {
       i?.forEach((e) {keyMaps.add(e.keyMap);});
    });

    return Set.from(keyMaps);
   }
   static Future<List<PurchasedPackage>> getPurchasedPackages() async {
    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
      Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };
    var url = Uri.https(Config.apiURL, Config.Purchase);
    var response = await client.get(url, headers: requestHeaders);
    var data =jsonDecode(response.body);
    if (response.statusCode == 200) {
      return packagesFromJson(data['purchasedPackages']);
    }
    return [];
   }
}