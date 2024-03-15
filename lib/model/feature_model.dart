
class FeatureModel {
  String name;
  String description;
  String id;

  FeatureModel({
    required this.name,
    required this.description,
    required this.id,
  });

  FeatureModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        id = json['feature_id'];
}