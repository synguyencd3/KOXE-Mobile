import 'package:flutter/material.dart';
import 'package:mobile/model/payment_request.dart';
import 'package:mobile/services/salon_service.dart';
import '../../model/Payment_Method_Response.dart';


Future<void> createPayment(String createDate,  String custormerPhone, String custormerFullname, String reason, int amount, bool status, String method) async {
  var payment = PaymentRequest(
      cusPhone: custormerPhone,
      cusName: custormerFullname,
      reason: reason,
      methodPaymentId: method,
      amount: amount,
    );

  await SalonsService.createPayment(payment);
}

void showForm(BuildContext context, List<PaymentMethod> _methods) {
  final _formKey = GlobalKey<FormState>();
  String createDate = DateTime.now().toString();
  String custormerPhone = '';
  String custormerFullname = '';
  String reason = '';
  int amount = 0;
  bool status = false;
  String? selectedOption;

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
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: DropdownButtonFormField<String>(
                    value: selectedOption,
                    onChanged: (value) {
                        selectedOption = value;
                    },
                    items: _methods.map((e) => DropdownMenuItem(child: Text(e.type ?? ""), value: e.id)).toList(),
                    decoration: InputDecoration(
                      labelText: 'Vui lòng chọn phương thức thanh toán',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                       createPayment(createDate, custormerPhone, custormerFullname, reason, amount, status, selectedOption!);
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