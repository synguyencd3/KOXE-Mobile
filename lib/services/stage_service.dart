import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/config.dart';
import 'package:mobile/model/appointment_model.dart';
import 'package:mobile/model/stage_model.dart';
import 'package:mobile/model/time_busy_model.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/shared_service.dart';

class StageService {
  static var client = http.Client();

  static Future<StageModel> getStageDetail(String stageId) async {
    await APIService.refreshToken();
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.accessToken}',
    };

    var url = Uri.https(Config.apiURL, '${Config.stagesAPI}/$stageId');
    var response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //print(data);
      return StageModel.fromJson(data['stage']);
    }
    return StageModel();
  }
}
