List<Promotion> promotionsFromJson(dynamic str) =>
    List<Promotion>.from((str).map((x) => Promotion.fromJson(x)));


class Promotion {
  String? id;
  String? title;
  String? description;
  String? thumbnail;
  String? createdAt;
  String? startDate;
  String? endDate;
  SalonPromotion? salon;

  Promotion(
      {this.id,
        this.title,
        this.description,
        this.thumbnail,
        this.createdAt,
        this.startDate,
        this.endDate,
        this.salon});

  Promotion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    thumbnail = json['thumbnail'];
    createdAt = json['createdAt'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    salon = json['salon'] != null ? new SalonPromotion.fromJson(json['salon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['thumbnail'] = this.thumbnail;
    data['createdAt'] = this.createdAt;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    if (this.salon != null) {
      data['salon'] = this.salon!.toJson();
    }
    return data;
  }
}

class SalonPromotion {
  String? salonId;
  String? name;

  SalonPromotion({this.salonId, this.name});

  SalonPromotion.fromJson(Map<String, dynamic> json) {
    salonId = json['salon_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salon_id'] = this.salonId;
    data['name'] = this.name;
    return data;
  }
}