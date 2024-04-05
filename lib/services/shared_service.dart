import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/login_response_model.dart';

// Class này dùng để cache thông tin user sau khi gọi api xuống
// thư viện sử dụng trong class này lưu thông tin bằng SQLite (google)
class SharedService {


  static Future<bool> isLoggedIn() async {
    var isKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");

    return isKeyExist;
  }

  static Future<LoginResponse?> loginDetails() async {
    var isKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");

    if (isKeyExist) {
      var cacheData = await APICacheManager().getCacheData("login_details");
      return loginResponseJson(cacheData.syncData);
    }
  }

  static Future<DateTime?> updatedTime() async {
     var isKeyExist =
        await APICacheManager().isAPICacheKeyExist("update_time");

    if (isKeyExist) {
      var cacheData = await APICacheManager().getCacheData("update_time");
      return DateTime.parse(cacheData.syncData);
    }
  }

  static Future<void> updateTime() async {
     APICacheDBModel cacheDBModel = APICacheDBModel(
        key: "update_time", syncData: DateTime.now().toString());
    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<void> setLoginDetails(LoginResponse model) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
        key: "login_details", syncData: jsonEncode(model.toJson()));
    await APICacheManager().addCacheData(cacheDBModel);
    await updateTime();
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache("login_details");
    Navigator.pushNamedAndRemoveUntil(
      context, 
      '/login',
      (route) => false
    );
  }
}
