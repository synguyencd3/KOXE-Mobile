
import 'package:mobile/model/accessory_request_model.dart';
import 'package:mobile/model/maintain_invoice_model.dart';
import 'package:mobile/model/maintaince_request_model.dart';
import 'package:mobile/model/maintaince_model.dart';
import 'package:mobile/model/accessory_model.dart';

List<InvoiceModel> invoiceFromJson(dynamic str) =>
    List<InvoiceModel>.from((str).map((x) => InvoiceModel.fromJson(x)));

class InvoiceModel {
  String? invoiceId;
  String? id;
  int? expense;
  String? createAt;
  String fullName;
  String? email;
  String phone;
  String carName;
  String? note;
  String licensePlate;
  List<MaintainceRequestModel>? services;
  List<AccessoryRequestModel>? accessoriesRequest;
  List<AccessoryModel>? accessories;
  late List<MaintainInvoiceModel> maintainces = [];

  InvoiceModel({
    this.invoiceId,
    this.expense,
    this.createAt,
    required this.fullName,
    this.email,
    required this.phone,
    required this.carName,
    this.note,
    required this.licensePlate,
    required this.services,
    this.accessoriesRequest,
  });

  InvoiceModel.fromJson(Map<String, dynamic> json)
      : id = json['invoice_id'],
        expense = json['total'],
        createAt = json['invoiceDate'],
        fullName = json['fullname'],
        email = json['email'],
        phone = json['phone'],
        note = json['note'],
        licensePlate = json['licensePlate'],
        carName = json['carName'],
        maintainces = maintainceInvoiceFromJson(json['maintenanceServices']),
        accessories = accessoriesFromJson(json['accessories']);



  Map<String, dynamic> toJson() => {
        'invoiceId': invoiceId,
        'expense': expense,
        'fullname': fullName,
        'email': email,
        'phone': phone,
        'carName': carName,
        'note': note,
        'licensePlate': licensePlate,
        'services': services!.map((e) => e.toJson()).toList(),
        'accessories': accessoriesRequest!.map((e) => e.toJson()).toList(),
      };
}
