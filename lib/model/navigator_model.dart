List<NavigatorModel> navigatorFromJson(dynamic str) =>
    List<NavigatorModel>.from(
        (str).map((x) => NavigatorModel.fromJson(x)));

class NavigatorModel{
  final int amount;
  final String name;
  final String phone;
  final int numComplete;

  NavigatorModel({required this.amount, required this.numComplete, required this.name, required this.phone});

  NavigatorModel.fromJson(Map<String, dynamic> json)
      : amount = json['amount'],
        name =  json['user']['name'] ,
        phone =  json['user']['phone'] ,
        numComplete = json['numOfCompletedTran'];

}