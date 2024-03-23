import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';
import '../model/package_model.dart';

class PackageService {
  //static var client = http.Client();
  static Future<List<PackageModel>> getAllPackages() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.http(Config.apiURL, Config.getAllPackageAPI);

    var response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var packagesData = data['packages'];
      //print(packagesData['packages']);
      return packagesFromJson(packagesData['packages']);
    }
    return [];
  }

}