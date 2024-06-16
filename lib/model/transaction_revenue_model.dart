import 'package:mobile/model/transaction_model.dart';

List<TransactionRevenueModel> transactionsRevenueFromJson(dynamic str) =>
    List<TransactionRevenueModel>.from((str).map((x) => TransactionRevenueModel.fromJson(x)));

class TransactionRevenueModel {
  int? revenue;
  List<TransactionModel>? transaction;

  TransactionRevenueModel({
    this.revenue,
    this.transaction,
  });

  TransactionRevenueModel.fromJson(Map<String, dynamic> json)
      : revenue = json['revenue'],
        transaction = json['transaction'] != null
            ? List<TransactionModel>.from(json['transaction'].map((x) => TransactionModel.fromJson(x)))
            : [];
}
