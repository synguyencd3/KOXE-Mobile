
class MaintainceRequestModel {
  final String id;
  final int quantity;

  MaintainceRequestModel({
    required this.id,
    required this.quantity,
   // required this.quantity,
  });

  Map<String, dynamic> toJson() => {
         'maintenance_id': id,
        'quantity': quantity,
  };
}
