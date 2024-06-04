import 'package:mobile/model/promotion_model.dart';

class PromotionArticleModel {
  String? promotionId;
  String? title;
  String? description;
  String? contentHtml;
  String? contentMarkdown;
  String? startDate;
  String? endDate;
  List<String>? banner;
  String? createdAt;
  String? updatedAt;
  SalonPromotion? salon;

  PromotionArticleModel(
      {this.promotionId,
        this.title,
        this.description,
        this.contentHtml,
        this.contentMarkdown,
        this.startDate,
        this.endDate,
        this.banner,
        this.createdAt,
        this.updatedAt,
        this.salon});

  PromotionArticleModel.fromJson(Map<String, dynamic> json) {
    promotionId = json['promotion_id'];
    title = json['title'];
    description = json['description'];
    contentHtml = json['contentHtml'];
    contentMarkdown = json['contentMarkdown'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    banner = json['banner'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    salon = json['salon'] != null ? new SalonPromotion.fromJson(json['salon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['promotion_id'] = this.promotionId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['contentHtml'] = this.contentHtml;
    data['contentMarkdown'] = this.contentMarkdown;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['banner'] = this.banner;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.salon != null) {
      data['salon'] = this.salon!.toJson();
    }
    return data;
  }
}
