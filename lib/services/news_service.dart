import 'dart:convert';

import 'package:mobile/model/news_model.dart';

import '../config.dart';
import '../model/articles_model.dart';
import 'package:http/http.dart' as http;

class NewsService {

  static var client = http.Client();

  static Future<List<Articles>> getArticles(int page, int perPage) async {
    // final Map<String, String> param = <String, String>{
    //   'q': 'f1',
    //   'language': 'en',
    //   'pageSize': '4',
    //   'apiKey': Config.apiKey
    // };

    //var url = Uri.https(Config.newsURL, Config.newsAPi, param);
    var url = Uri.parse(Config.news+"?page=${page}&per_page=${perPage}");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return articlesFromJson(data['articles']);
    }
    return [];
  }

  static Future<News?> getNews(String id) async {
    // final Map<String, String> param = <String, String>{
    //   'q': 'f1',
    //   'language': 'en',
    //   'pageSize': '4',
    //    'apiKey': Config.apiKey
    // };

    //var url = Uri.https(Config.newsURL, Config.newsAPi, param);
    var url = Uri.parse("${Config.news}/$id");

    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body);
      return News.fromJson(data);
    }
    return null;
  }
}