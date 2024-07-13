import 'package:mobile/model/salon_model.dart';
List<SalonPaymentModel> PaymentsFromJson(dynamic str) =>
    List<SalonPaymentModel>.from((str).map((x) => SalonPaymentModel.fromJson(x)));
class SalonPaymentModel {
  String? createDate;
  String? id;
  String? custormerPhone;
  String? custormerFullname;
  String? reason;
  String? creator;
  String? payment_method;
  int? amount;
  bool? status;
  Salon? salon;

  SalonPaymentModel(
      {this.createDate,
        this.id,
        this.custormerPhone,
        this.custormerFullname,
        this.reason,
        this.creator,
        this.amount,
        this.payment_method,
        this.status,
        this.salon});

  SalonPaymentModel.fromJson(Map<String, dynamic> json) {
    createDate = json['create_date'];
    id = json['id'];
    custormerPhone = json['custormer_phone'];
    custormerFullname = json['custormer_fullname'];
    reason = json['reason'];
    creator = json['creator'];
    amount = json['amount'];
    payment_method = json['payment_method'];
    status = json['status'];
    salon = json['salon'] != null ? new Salon.fromJson(json['salon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_date'] = this.createDate;
    data['id'] = this.id;
    data['custormer_phone'] = this.custormerPhone;
    data['custormer_fullname'] = this.custormerFullname;
    data['reason'] = this.reason;
    data['creator'] = this.creator;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['payment_method'] = this.payment_method;
    if (this.salon != null) {
      data['salon'] = this.salon!.toJson();
    }
    return data;
  }
}
