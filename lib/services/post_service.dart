import 'dart:convert';

import 'package:mobile/config.dart';
import 'package:mobile/model/post_model.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/shared_service.dart';
import 'package:http/http.dart' as http;

class PostService {
  static Future<List<PostModel>> getAllPosts(int page, int perPage) async {
    await APIService.refreshToken();
    var loginDetail = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      'Authorization': 'Bearer ${loginDetail?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.getPosts, {
      "page": page.toString(),
      "per_page": perPage.toString()
    });

    var response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return postModelFromJson(data['posts']['posts']);
    }
    return [];
  }

  static Future<bool> createPost(PostModel postModel) async {
    // print(postModel.salonId);
    // return true;
    await APIService.refreshToken();
    var loginDetail = await SharedService.loginDetails();


    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      'Authorization': 'Bearer ${loginDetail?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.posts);
print(jsonEncode(postModel.toJson()));
    var response = await http.post(url,
        headers: requestHeaders, body: jsonEncode(postModel.toJson()));

    return response.statusCode == 201;
  }

  static Future<PostModel> getPostDetail(String id) async {
    await APIService.refreshToken();
    var loginDetail = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      'Authorization': 'Bearer ${loginDetail?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, '${Config.posts}/$id');

    var response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
    return PostModel.fromJson(data['post']);
    }
    return PostModel(text: 'Error');
  }

  static Future<bool> blockUser(String postId) async {
    await APIService.refreshToken();
    var loginDetail = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': "*",
      'Authorization': 'Bearer ${loginDetail?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, Config.blocksAPI);
    var response = await http.post(url, headers: requestHeaders, body: jsonEncode({'postId ': postId}));
    return response.statusCode == 200;
  }

}
