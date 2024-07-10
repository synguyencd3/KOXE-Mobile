List<PaymentMethod> PaymentMethodsFromJson(dynamic str) =>
    List<PaymentMethod>.from((str).map((x) => PaymentMethod.fromJson(x)));

class PaymentMethod {
  String? id;
  String? type;
  String? content;
  String? fullname;

  PaymentMethod({this.id, this.type, this.content, this.fullname});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    content = json['content'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['content'] = this.content;
    data['fullname'] = this.fullname;
    return data;
  }
}