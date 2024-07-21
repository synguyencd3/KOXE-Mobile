import 'package:mobile/model/process_model.dart';
import 'package:mobile/model/stage_model.dart';
import 'package:mobile/model/user_transaction_model.dart';

List<TransactionModel> transactionsFromJson(dynamic str) =>
    List<TransactionModel>.from((str).map((x) => TransactionModel.fromJson(x)));

class TransactionModel {
  String? id;
  String? status;
  List<dynamic>? checked;
  List<dynamic>? commissionList;
  List<dynamic>? ratingList;
  process? processData;
  StageModel? stage;
  UserTransactionModel? userTransaction;
  DateTime? createAt;

  TransactionModel({
    this.id,
    this.status,
    this.checked,
    this.commissionList,
    this.processData,
    this.stage,
  });

  TransactionModel.fromJson(Map<String, dynamic> json)
      : id = json['transaction_id'],
  createAt = DateTime.parse(json['createdAt']),
        status = json['status'],
        checked = json['checked'],
        commissionList = json['commissionList'],
        ratingList = json['ratingList'],
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
        //'commission_amount': commissionList,
        'process': processData!.toJson(),
      };
}
