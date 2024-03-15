import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/config.dart';
import 'package:mobile/model/car.dart';

class CarsService {
  static var client = http.Client();

  static Future<List<Car>> getAll() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
    };

    var url = Uri.http(Config.apiURL, Config.getCarsAPI);

    var response = await http.get(url);
    
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return carsFromJson(data['data']['cars']);
    }
    return [];
  }
}