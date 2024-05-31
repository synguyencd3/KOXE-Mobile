import 'package:mobile/model/process_model.dart';
import 'package:mobile/model/stage_model.dart';
import 'package:mobile/model/user_transaction_model.dart';

List<TransactionModel> transactionsFromJson(dynamic str) =>
    List<TransactionModel>.from((str).map((x) => TransactionModel.fromJson(x)));

class TransactionModel {
  String? id;
  String? status;
  List<dynamic>? checked;
  List<dynamic>? commissionAmount;
  process? processData;
  StageModel? stage;
  UserTransactionModel? userTransaction;

  TransactionModel({
    this.id,
    this.status,
    this.checked,
    this.commissionAmount,
    this.processData,
    this.stage,
  });

  TransactionModel.fromJson(Map<String, dynamic> json)
      : id = json['transaction_id'],
        status = json['status'],
        checked = json['checked'],
        commissionAmount = json['commissionAmount'],
        processData = json['process'] != null
            ? new process.fromJson(json['process'])
            : null,
        stage = json['stage'] != null
            ? new StageModel.fromJson(json['stage'])
            : null,
        userTransaction = json['user'] != null
            ? new UserTransactionModel.fromJson(json['user'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'checked': checked,
        'commission_amount': commissionAmount,
        'process': processData!.toJson(),
      };
}
