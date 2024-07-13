List<NavigatorModel> navigatorFromJson(dynamic str) =>
    List<NavigatorModel>.from(
        (str).map((x) => NavigatorModel.fromJson(x)));

class NavigatorModel{
  final int amount;
  final String name;
  final String phone;
  final int numComplete;

  NavigatorModel({required this.amount, required this.name, required this.phone, required this.numComplete});

  NavigatorModel.fromJson(Map<String, dynamic> json)
      : amount = json['amount'],
        name = json.containsKey('user') ? json['user']['name'] : json['salon']['name'],
        phone = json.containsKey('user') ? json['user']['phone'] : json['salon']['phone'],
        numComplete = json['numOfCompletedTran'];

}