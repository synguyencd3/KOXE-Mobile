import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/shared_service.dart';
import 'dart:convert';
import '../config.dart';
import '../model/package_model.dart';

class PackageService {
  //static var client = http.Client();
  static Future<List<PackageModel>> getAllPackages() async {
    await APIService.refreshToken();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.https(Config.apiURL, Config.getAllPackageAPI);

    var response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //print(packagesData['packages']);
      return packagesFromJson(data['packages']);
    }
    return [];
  }

  static Future<PackageModel> getDetailPackage(String id) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.https(Config.apiURL, Config.getAllPackageAPI + '/$id');

    var response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var packagesData = data['package']['package'];

      return PackageModel.fromJson(packagesData);
    }
    return PackageModel(
        id: '', name: '', description: '', price: 0, features: []);
  }
}
