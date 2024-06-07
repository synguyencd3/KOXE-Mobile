import 'dart:convert';

import 'package:mobile/model/news_model.dart';
import 'package:mobile/model/promotion_article_model.dart';
import 'package:mobile/model/promotion_model.dart';

import '../config.dart';
import '../model/articles_model.dart';
import 'package:http/http.dart' as http;

class NewsService {

  static var client = http.Client();

  static Future<List<Articles>> getArticles(int page, int perPage) async {
    var url = Uri.parse(Config.news+"?page=${page}&per_page=${perPage}");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return articlesFromJson(data['articles']);
    }
    return [];
  }

  static Future<News?> getNews(String id) async {

    var url = Uri.parse("${Config.news}/$id");

    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body);
      return News.fromJson(data);
    }
    return null;
  }

  static Future<List<Promotion>> getPromotions(int page, int perPage) async {
    var url = Uri.https(Config.apiURL, Config.promotionAPI, {
      "page": page.toString(),
      "per_page": perPage.toString(),
    });

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return promotionsFromJson(data['promotions']['promotions']);
    }
    return [];
  }

  static Future<List<Promotion>> getSalonPromotions(String salonId) async {
    var url = Uri.https(Config.apiURL, '${Config.promotionAPI}/salon/$salonId');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return promotionsFromJson(data['promotion']);
    }
    return [];
  }

  static Future<PromotionArticleModel?> getPromotion(String id) async {
    var url = Uri.https(Config.apiURL, '${Config.promotionAPI}/${id}');

    var response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return PromotionArticleModel.fromJson(data['promotion']);
    }
    return null;
  }

}