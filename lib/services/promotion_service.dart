import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile/model/promotion_request.dart';
import 'package:mobile/services/news_service.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/services/shared_service.dart';

import '../config.dart';
import '../model/promotion_model.dart';
import 'api_service.dart';

class PromotionService {
  static Future<bool?> NewPromotion(PromotionRequest model) async {
    await APIService.refreshToken();
    var LoginInfo = await SharedService.loginDetails();
    var url = Uri.https(Config.apiURL, Config.promotionAPI);
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      HttpHeaders.authorizationHeader: 'Bearer ${LoginInfo?.accessToken}',
    };

    var param = model.toJson();
  print(param);
    var request = http.MultipartRequest("POST", url);
    request.headers.addAll(requestHeaders);
    request.fields['title'] = param['title'];
    request.fields['description'] = param['description'];
    request.fields['contentHtml'] = "";
    request.fields['contentMarkdown'] = param['contentMarkdown'];
    request.fields['startDate'] = param['startDate'];
    request.fields['endDate'] = param['endDate'];

    if (model.banner != null) {
      model.banner?.forEach(
            (element) async {
          request.files
              .add(await http.MultipartFile.fromPath("banner", element));
        },
      );
    }
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    var data = jsonDecode(responseString);
    if (data['status'] == 'success') return true;
    return false;
  }

  static Future<List<Promotion>> getPromotions() async {
    String salonId = await SalonsService.isSalon();
    return NewsService.getSalonPromotions(salonId);
  }
}