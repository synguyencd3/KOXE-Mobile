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

    var url = Uri.https(Config.apiURL, Config.getPosts,
        {"page": page.toString(), "per_page": perPage.toString()});

    var response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return postModelFromJson(data['posts']['posts']);
    }
    return [];
  }

  static Future<bool> createPost(PostModel postModel) async {
    await APIService.refreshToken();
    var loginDetail = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ${loginDetail?.accessToken}',
    };
    var uri = Uri.https(Config.apiURL, Config.posts);

    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(requestHeaders);
    request.fields['text'] = postModel.text ?? '';
    request.fields['salons'] = postModel.salonId!.join(',');
    request.fields['brand'] = postModel.car?.brand ?? '';
    request.fields['type'] = postModel.car?.type ?? '';
    request.fields['mfg'] = postModel.car?.mfg ?? '';
    request.fields['version'] = postModel.car?.model ?? '';
    request.fields['gear'] = postModel.car?.gear ?? '';
    request.fields['fuel'] = postModel.fuel ?? '';
    request.fields['origin'] = postModel.car?.origin ?? '';
    request.fields['design'] = postModel.design ?? '';
    request.fields['seat'] = postModel.car?.seat.toString() ?? '';
    request.fields['color'] = postModel.color ?? '';
    request.fields['licensePlate'] = postModel.licensePlate ?? '';
    request.fields['ownerNumber'] = postModel.ownerNumber?.toString() ?? '';
    request.fields['accessory'] = postModel.accessory.toString();
    request.fields['registrationDeadline'] = postModel.registrationDeadline.toString();
    request.fields['kilometer'] = postModel.car?.kilometer.toString() ?? '';
    request.fields['price'] = postModel.car?.price.toString() ?? '';
    request.fields['address'] = postModel.address ?? '';
    request.fields['title'] = postModel.title ?? '';


    if (postModel.image != null) {
      for (var imagePath in postModel.image!) {
        var file = await http.MultipartFile.fromPath('image', imagePath);
        request.files.add(file);
      }
    }
    var response = await request.send();

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
    //print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
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
    var response = await http.post(url,
        headers: requestHeaders, body: jsonEncode({'postId ': postId}));
    return response.statusCode == 200;
  }
}
