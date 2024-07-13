import 'package:mobile/model/navigator_model.dart';
class TransactionNavigatorModel {
  final List<NavigatorModel> navigators;
  final int totalAmount;
  final int totalComplete;

  TransactionNavigatorModel({required this.navigators, required this.totalAmount, required this.totalComplete});

  TransactionNavigatorModel.fromJson(Map<String, dynamic> json)
  : navigators = navigatorFromJson(json['data']),
        totalAmount = json['totals']['totalAmount'],
        totalComplete = json['totals']['totalNumOfCompletedTran'];
}