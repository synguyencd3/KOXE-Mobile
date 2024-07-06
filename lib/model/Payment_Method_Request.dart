
class PaymentMethodRequest {
  String? type;
  String? content;
  String? fullname;

  PaymentMethodRequest({this.type, this.content, this.fullname});

  PaymentMethodRequest.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    content = json['content'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['content'] = this.content;
    data['fullname'] = this.fullname;
    return data;
  }
}