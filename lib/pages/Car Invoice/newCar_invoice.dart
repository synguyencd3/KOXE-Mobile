import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/CarInvoice_request.dart';
import 'package:mobile/services/CarInvoice_Service.dart';
import 'package:mobile/services/cars_service.dart';
import 'package:mobile/services/process_service.dart';
import 'package:mobile/services/salon_service.dart';

import '../../model/CarInvoice_response.dart';
import '../../model/car_model.dart';
import '../../model/employee_model.dart';
import '../../model/process_model.dart';

class CarInvoiceForm extends StatefulWidget {
  @override
  _CarInvoiceFormState createState() => _CarInvoiceFormState();
}

class _CarInvoiceFormState extends State<CarInvoiceForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _fullName = TextEditingController();
  var _email = TextEditingController();
  var _phoneNumber = TextEditingController();
  var _expense = TextEditingController();
  var _note = TextEditingController();
  Car? _selectedCar;
  process? _selectedProcess;
  Employee? _selectedEmployee;

  //List<String> _dropdownItems = ['Option 1', 'Option 2', 'Option 3'];
  List<Car> cars = [];
  List<process> processes = [];
  List<Employee> employees = [];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    var invoice = InvoiceRequest(
      carId: _selectedCar?.id,
      fullname: _fullName.text,
      email: _email.text,
      phone: _phoneNumber.text,
      expense: int.parse(_expense.text),
      processId: _selectedProcess!.id!,
      note: _note.text,
        employeeId:  _selectedEmployee!.userId!
    );

    CarInvoiceService.newInvoice(invoice).then((value) {
      if (value!) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tạo thành công'),
              backgroundColor: Colors.green,
            )
        );
        Navigator.pop(context);
      }
      else
      {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Có lỗi xảy ra, vui lòng thử lại sau'),
              backgroundColor: Colors.red,
            )
        );
      }
    });
    }
  }

  void getCars() async {
    var data = await SalonsService.getDetail(null);
    setState(() {
      cars = data;
      _selectedCar = cars[0];
      _expense.text = cars[0].price.toString();
    });
  }

  void getProcesses() async {
    var data = await ProcessService.getAll();
    setState(() {
      processes = data;
      _selectedProcess = processes[0];
    });
  }

  void getEmployees() async {
    var data = await SalonsService.getEmployees();
    setState(() {
      employees = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCars();
    getProcesses();
    getEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo giao dịch mơi'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Họ tên'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _fullName.text = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    // You can add additional email validation logic here
                    return null;
                  },
                  onSaved: (value) {
                    _email.text = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Điện thoại'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _phoneNumber.text = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Note'),
                  onSaved: (value) {
                    _note.text = value!;
                  },
                ),
                TextFormField(
                  controller: _expense,
                  decoration: InputDecoration(labelText: 'Thanh toán'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your expense';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _expense.text = value!;
                  },
                ),
              DropdownButtonFormField<Employee>(
                value: _selectedEmployee,
                items: employees.map((Employee value) {
                  return DropdownMenuItem<Employee>(
                    value: value,
                    child: Text(value.fullname ?? ""),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedEmployee=value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Nhân viên'),
              ),
                DropdownButtonFormField<Car>(
                  value: _selectedCar,
                  items: cars.map((Car value) {
                    return DropdownMenuItem<Car>(
                      value: value,
                      child: Text(value.name?? ""),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                     _selectedCar=value!;
                     _expense.text = value.price.toString();
                    });
                  },
                  decoration: InputDecoration(labelText: 'Xe'),
                ),
                DropdownButtonFormField<process>(
                  value: _selectedProcess,
                  items: processes.map((process value) {
                    return DropdownMenuItem<process>(
                      value: value,
                      child: Text(value.name!),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedProcess = value!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Quy trình'),
                ),
                TextButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}