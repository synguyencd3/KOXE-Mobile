class CarSalon {
  String salonId;
  String name;

  CarSalon({required this.salonId, required this.name});

  factory CarSalon.fromJson(Map<String, dynamic> json) {
    return CarSalon(
      salonId: json['salon_id'],
      name: json['name'],
    );
  }
}