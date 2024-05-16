import 'package:mobile/model/process_model.dart';
import 'package:mobile/model/process_model.dart';
List<TransactionModel> transactionsFromJson(dynamic str) =>
    List<TransactionModel>.from((str).map((x) => TransactionModel.fromJson(x)));

class TransactionModel {
  String? id;
String? status;
 List<String>? checked;
 List<String>? commissionAmount;
  process? processData;

  TransactionModel({
    this.id,
    this.status,
    this.checked,
    this.commissionAmount,
    this.processData,
  });

  TransactionModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        status = json['status'],
        checked = json['checked'],
        commissionAmount = json['commissionAmount'],
        processData = json['process'] != null ? new process.fromJson(json['process']) : null;
  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'checked': checked,
        'commission_amount': commissionAmount,
        'process': processData!.toJson(),
  };
}

