import 'package:mobile/model/promotion_model.dart';

class PromotionRequest {

  String? title;
  String? description;
  String? contentHtml;
  String? contentMarkdown;
  String? startDate;
  String? endDate;
  List<String>? banner;

  PromotionRequest(
      {
        this.title,
        this.description,
        this.contentHtml,
        this.contentMarkdown,
        this.startDate,
        this.endDate,
        this.banner,
 });

  PromotionRequest.fromJson(Map<String, dynamic> json) {

    title = json['title'];
    description = json['description'];
    contentHtml = json['contentHtml'];
    contentMarkdown = json['contentMarkdown'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    banner = json['banner'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['contentHtml'] = this.contentHtml;
    data['contentMarkdown'] = this.contentMarkdown;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['banner'] = this.banner;
    return data;
  }
}