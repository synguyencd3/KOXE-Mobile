
class AccessoryRequestModel {
  final String id;

  AccessoryRequestModel({
    required this.id,
  });

  Map<String, dynamic> toJson() =>
      {
        'accessory_id': id,
      };
}