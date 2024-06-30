import 'package:mobile/model/feature_model.dart';

List<PackageModel> packagesFromJson(dynamic str) => str == null
    ? []
    : List<PackageModel>.from((str).map((x) => PackageModel.fromJson(x)));

class PackageModel {
  late String id;
  late String name;
  late String description;
  late int price;
  late List<FeatureModel> features;
  String? purchasedTime;
  String? expirationTime;

  PackageModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.features,
  });

  PackageModel.fromJson(Map<String, dynamic> json)
      : id = json['package_id'],
        name = json['name'],
        description = json['description'],
        price = json['price'],
        features = json['features'] == null
            ? []
            : List<FeatureModel>.from(
                json['features'].map((x) => FeatureModel.fromJson(x)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    return data;
  }
}
