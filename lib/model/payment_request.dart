

class PaymentRequest {
  String? cusPhone;
  String? cusName;
  String? reason;
  int? amount;
  String? salonId;

  PaymentRequest(
      {this.cusPhone, this.cusName, this.reason, this.amount, this.salonId});

  PaymentRequest.fromJson(Map<String, dynamic> json) {
    cusPhone = json['cusPhone'];
    cusName = json['cusName'];
    reason = json['reason'];
    amount = json['amount'];
    salonId = json['salonId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cusPhone'] = this.cusPhone;
    data['cusName'] = this.cusName;
    data['reason'] = this.reason;
    data['amount'] = this.amount;
    data['salonId'] = this.salonId;
    return data;
  }
}