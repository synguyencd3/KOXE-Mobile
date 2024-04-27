
class MaintainceRequestModel {
  late String id;
  //late int quantity;

  MaintainceRequestModel({
    required this.id,
   // required this.quantity,
  });

  Map<String, dynamic> toJson() => {
         'maintenance_id': id,
        // 'quantity': quantity,
  };
}
