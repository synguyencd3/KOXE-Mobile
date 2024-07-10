class CarSalon {
  String salonId;
  String address;
  String name;

  CarSalon({required this.salonId, required this.name, required this.address});

  factory CarSalon.fromJson(Map<String, dynamic> json) {
    return CarSalon(
      salonId: json['salon_id'] ?? "",
      address: json['address'] ?? "",
      name: json['name'] ?? "",
    );
  }
}