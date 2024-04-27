List<invoiceStat> invoiceStatFromJson(dynamic str) =>
    List<invoiceStat>.from((str).map((x) => invoiceStat.fromJson(x)));
class invoiceStat {
  String? invoiceId;
  String? type;
  int? expense;
  String? note;
  String? createAt;
  String? fullname;
  String? email;
  String? phone;
  String? licensePlate;
  String? carName;
 // Null? limitKilometer;
 // Null? months;
 // Null? policy;
 // List<String>? maintenanceServices;
  //Null? accessories;
  //Seller? seller;


  invoiceStat(
      {this.invoiceId,
      this.type,
      this.expense,
      this.note,
      this.createAt,
      this.fullname,
      this.email,
      this.phone,
      this.licensePlate,
      this.carName,
     // this.limitKilometer,
     // this.months,
      //this.policy,
      //this.maintenanceServices,
      //this.accessories,
      });

  invoiceStat.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoice_id'];
    type = json['type'];
    expense = json['expense'];
    note = json['note'];
    createAt = json['create_at'];
    fullname = json['fullname'];
    email = json['email'];
    phone = json['phone'];
    licensePlate = json['licensePlate'];
    carName = json['carName'];
   // limitKilometer = json['limit_kilometer'];
   // months = json['months'];
   // policy = json['policy'];
    //maintenanceServices = json['maintenanceServices'];
   // accessories = json['accessories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_id'] = this.invoiceId;
    data['type'] = this.type;
    data['expense'] = this.expense;
    data['note'] = this.note;
    data['create_at'] = this.createAt;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['licensePlate'] = this.licensePlate;
    data['carName'] = this.carName;
   // data['limit_kilometer'] = this.limitKilometer;
  //  data['months'] = this.months;
   // data['policy'] = this.policy;
    //data['maintenanceServices'] = this.maintenanceServices;
   // data['accessories'] = this.accessories;
    return data;
  }
}

