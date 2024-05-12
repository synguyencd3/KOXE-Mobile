import 'package:mobile/model/accessory_model.dart';
import 'package:mobile/model/salon_model.dart';


List<CarInvoice> carInvoicesFromJson(dynamic str) =>
    List<CarInvoice>.from((str).map((x) => CarInvoice.fromJson(x)));

class CarInvoice {
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
  int? limitKilometer;
  int? months;
  String? policy;
  bool? done;
  List<String>? maintenanceServices;
  List<String>? accessories;
  Salon? seller;
  LegalsUser? legalsUser;

  CarInvoice(
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
        this.limitKilometer,
        this.months,
        this.policy,
        this.done,
        this.maintenanceServices,
        this.accessories,
        this.seller,
        this.legalsUser});

  CarInvoice.fromJson(Map<String, dynamic> json) {
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
    limitKilometer = json['limit_kilometer'];
    months = json['months'];
    policy = json['policy'];
    done = json['done'];
    maintenanceServices = json['maintenanceServices'] == null ? null: json['maintenanceServices'].cast<String>();
    accessories = json['accessories'] == null?  null :json['accessories'].cast<String>();
    seller =
    json['seller'] != null ? Salon.fromJson(json['seller']) : null;
    legalsUser = json['legals_user'] != null
        ? LegalsUser.fromJson(json['legals_user'])
        : null;
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
   data['limit_kilometer'] = this.limitKilometer;
   data['months'] = this.months;
   data['policy'] = this.policy;
   data['done'] = this.done;
  data['maintenanceServices'] = this.maintenanceServices;
   data['accessories'] = this.accessories;
    if (this.seller != null) {
      data['seller'] = this.seller!.toJson();
    }
    if (this.legalsUser != null) {
      data['legals_user'] = this.legalsUser!.toJson();
    }
    return data;
  }
}


class LegalsUser {
  String? carId;
  String? phone;
  List<String>? details;
  String? currentPeriod;
  String? processId;

  LegalsUser(
      {this.carId,
        this.phone,
        this.details,
        this.currentPeriod,
        this.processId});

  LegalsUser.fromJson(Map<String, dynamic> json) {
    carId = json['car_id'];
    phone = json['phone'];
    details = json['details'] == null ? [""] : json['details'].cast<String>();
    currentPeriod = json['current_period'];
    processId = json['processId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_id'] = this.carId;
    data['phone'] = this.phone;
    data['details'] = this.details;
    data['current_period'] = this.currentPeriod;
    data['processId'] = this.processId;
    return data;
  }
}
