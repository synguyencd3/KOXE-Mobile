
class StatisticUserModel {
  final int totalExpense;
  final int totalBuyCar;
  final int totalAccessory;
  final int totalMaintenance;

  StatisticUserModel({
    required this.totalExpense,
    required this.totalBuyCar,
    required this.totalAccessory,
    required this.totalMaintenance,
  });

  factory StatisticUserModel.fromJson(Map<String, dynamic> json) {
    return StatisticUserModel(
      totalExpense: json['totalExpense'],
      totalBuyCar: json['totalExpenseBuyCar'],
      totalAccessory: json['totalExpenseBuyAccessory'],
      totalMaintenance: json['totalExpenseMaintenance'],
    );
  }

}