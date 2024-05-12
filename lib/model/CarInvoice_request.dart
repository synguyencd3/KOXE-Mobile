class InvoiceRequest {
  String? carId;
  String? salonId;
  String? note;
  String? fullname;
  String? email;
  String? phone;
  int? expense;
  String? processId;

  InvoiceRequest(
      {this.carId,
        this.salonId,
        this.note,
        this.fullname,
        this.email,
        this.phone,
        this.expense,
        this.processId});

  InvoiceRequest.fromJson(Map<String, dynamic> json) {
    carId = json['carId'];
    salonId = json['salonId'];
    note = json['note'];
    fullname = json['fullname'];
    email = json['email'];
    phone = json['phone'];
    expense = json['expense'];
    processId = json['processId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carId'] = this.carId;
    data['salonId'] = this.salonId;
    data['note'] = this.note;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['expense'] = this.expense;
    data['processId'] = this.processId;
    return data;
  }
}