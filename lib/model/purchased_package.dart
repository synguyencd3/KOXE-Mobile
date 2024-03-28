List<PurchasedPackage> packagesFromJson(dynamic str) =>
str == null ? [] :
    List<PurchasedPackage>.from((str).map((x) => PurchasedPackage.fromJson(x)));
class PurchasedPackage {
  late final String package_id;
  List<Features>? features;

  PurchasedPackage({
    required this.package_id,
    this.features
  });

  PurchasedPackage.fromJson(Map<String, dynamic> json) {
    package_id = json['package_id'];
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_id'] = this.package_id;
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Features {
  String? keyMap;

  Features({this.keyMap});

  Features.fromJson(Map<String, dynamic> json) {
    keyMap = json['keyMap'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keyMap'] = this.keyMap;
    return data;
  }
}