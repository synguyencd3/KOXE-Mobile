import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/config.dart';
import 'package:mobile/model/car_model.dart';
import 'package:mobile/model/salon_model.dart';

class SalonsService {
  static var client = http.Client();

  static Future<List<Salon>> getAll() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
    };

    var url = Uri.http(Config.apiURL, Config.getSalonsAPI);

    var response = await http.get(url);
    
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data['salons']['salons']);
      return salonsFromJson(data['salons']['salons']);
    }
    return [];
  }

  static Future<Car?> getDetail(String salonId) async {

       Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
    };

    var url = Uri.http(Config.apiURL, '${Config.getCarsAPI}/$salonId');

    var response = await http.get(url);
    
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Car.fromJson(data); //carsFromJson(data['data']['cars']);
    }
    return null;
  }
}