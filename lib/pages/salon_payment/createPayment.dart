import 'package:flutter/material.dart';
import 'package:mobile/model/payment_request.dart';
import 'package:mobile/model/salon_payment_response.dart';
import 'package:mobile/services/salon_service.dart';

Future<void> _createPayment(String createDate,  String custormerPhone, String custormerFullname, String reason, int amount, bool status) async {
  // For simplicity, let's add a dummy object. You can implement a form to take input from the user.
  var payment = PaymentRequest(
      cusPhone: custormerPhone,
      cusName: custormerFullname,
      reason: reason,
      amount: amount,
    );

  await SalonsService.createPayment(payment);
}

void showForm(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  String createDate = DateTime.now().toString();
  String custormerPhone = '';
  String custormerFullname = '';
  String reason = '';
  int amount = 0;
  bool status = false;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Số điện thoại khách hàng'),
                  onChanged: (value) => custormerPhone = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập số điện thoại';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Tên khách hàng'),
                  onChanged: (value) => custormerFullname = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên khách hàng';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Đơn thanh toán'),
                  onChanged: (value) => reason = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Số tiền'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => amount = int.tryParse(value) ?? 0,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter amount';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                       _createPayment(createDate, custormerPhone, custormerFullname, reason, amount, status);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Tạo phiếu thanh toán'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}