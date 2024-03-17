List<Salon> salonsFromJson(dynamic str) =>
    List<Salon>.from((str).map((x) => Salon.fromJson(x)));

class Salon {
  String? salonId;
  String? name;
  String? address;
  String? image;
  String? email;
  String? phoneNumber;
  List<String>? banner;
  String? introductionHtml;
  String? introductionMarkdown;
  //List<String>? cars;

  Salon(
      {this.salonId,
      this.name,
      this.address,
      this.image,
      this.email,
      this.phoneNumber,
      this.banner,
      this.introductionHtml,
      this.introductionMarkdown,
      /*this.cars*/});

  Salon.fromJson(Map<String, dynamic> json) {
    salonId=json['salon_id'];
    json['name']==null? name='null':name = json['name'];
    json['address']==null? address="null":address = json['address'];
    image = json['image'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    banner = json['banner'].cast<String>();
    introductionHtml = json['introductionHtml'];
    introductionMarkdown = json['introductionMarkdown'];
    //cars = json['cars'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salon_id'] = this.salonId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['image'] = this.image;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['banner'] = this.banner;
    data['introductionHtml'] = this.introductionHtml;
    data['introductionMarkdown'] = this.introductionMarkdown;
    //data['cars'] = this.cars;
    return data;
  }
}