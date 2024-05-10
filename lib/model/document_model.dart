class Document {
  String? period;
  String? name;
  bool? reuse;
  int? order;
  List<Details>? details=[];

  Document({this.period, this.name, this.reuse, this.order, this.details});

  Document.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    name = json['name'];
    reuse = json['reuse'];
    order = json['order'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['period'] = this.period;
    data['name'] = this.name;
    data['reuse'] = this.reuse;
    data['order'] = this.order;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? id;
  String? name;
  String? updateDate;

  Details({this.id, this.name, this.updateDate});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['update_date'] = this.updateDate;
    return data;
  }
}