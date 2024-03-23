
class PurchasedPackage {
  late final String package_id;

  PurchasedPackage({
    required this.package_id
  });

  PurchasedPackage.fromJson(Map<String, dynamic> json) {
    package_id = json['package_id'];
  }
}