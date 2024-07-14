List<MaintainInvoiceModel> maintainceInvoiceFromJson(dynamic str) =>
    List<MaintainInvoiceModel>.from((str).map((x) => MaintainInvoiceModel.fromJson(x)));
class MaintainInvoiceModel {
  final String name;
  final int cost;

  MaintainInvoiceModel({
    required this.name,
    required this.cost,
  });

  MaintainInvoiceModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        cost = json['cost'];
}
