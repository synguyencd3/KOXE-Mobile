import 'package:mobile/model/accessory_model.dart';
import 'package:mobile/model/salon_model.dart';

List<AccessoryInvoiceModel> accessoriesInvoicefromJson(dynamic str) =>
    List<AccessoryInvoiceModel>.from(
        (str).map((x) => AccessoryInvoiceModel.fromJson(x)));


class AccessoryInvoiceModel {
  String? id;
  String fullname;
  String phone;
  String? email;
 String? salonName;
  String? invoiceDate;
  int? total;
  String? note;
  List<AccessoryModel> accessories;

  AccessoryInvoiceModel({
    this.id,
    required this.fullname,
    required this.phone,
     this.invoiceDate,
     this.total,
    this.note,
    required this.accessories,
    this.email,
  });

  AccessoryInvoiceModel.fromJson(Map<String, dynamic> json)
      : id = json['invoice_id'],
        fullname = json['fullname'],
        phone = json['phone'],
        invoiceDate = json['invoiceDate'],
        total = json['total'],
        note = json['note'],
        email = json['email'] != null ? json['email'] : '',
        salonName = json['salon']['salon_name'],
        accessories = accessoriesFromJson(json['accessories']);

  Map<String, dynamic> toJson() => {
        'fullname': fullname,
        'phone': phone,
        'email': email,
        'note': note,
        'accessories': accessoriesToJson(accessories),
      };
}
