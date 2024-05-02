import 'package:flutter/material.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/services/warranty_service.dart';

import '../../model/car_model.dart';
import '../../model/warranty_model.dart';



// class Car {
//   String? name;
//   // Add other properties as needed
//
//   Car({this.name});
// }

class WarrantyForm extends StatefulWidget {
  @override
  _WarrantyFormState createState() => _WarrantyFormState();
}

class _WarrantyFormState extends State<WarrantyForm> {
  final _formKey = GlobalKey<FormState>();
  // final List<Car> cars = [
  //   Car(name: "Car A"),
  //   Car(name: "Car B"),
  //   Car(name: "Car C"),
  //   // Add more Car objects as needed
  // ];
  List<Car> cars = [];


  late final _name = TextEditingController();
  late final _limitKilometers = TextEditingController();
  late final _months= TextEditingController();
  late final _policy= TextEditingController();
 // late final _note = TextEditingController();
  Car? _selectedCar;

  Warranty? warranty;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      initWarranty();
      getCars();
    }); 
  }

  void getCars() async {
    print('getting car');
    var salonId = await SalonsService.isSalon();
    var data = await SalonsService.getDetail(salonId);
    setState(() {
      cars = data;
    });
  }

  void initWarranty() {
    try {
      var data = ModalRoute
          .of(context)!
          .settings
          .arguments as Map;
      setState(() {
        warranty = data['warranty'];
      });
      _name.text = warranty?.name ?? "";
      _limitKilometers.text = warranty?.limitKilometer.toString() ?? "";
      _months.text = warranty?.months.toString() ?? "";
      _policy.text = warranty?.policy ?? "";
      //_email.text = salon?.email ?? "";
    } catch (exception) {
        print(exception);
    }
  }

  void updateWarranty() async {
    Warranty warrantyForm = Warranty(
      name: _name.text,
      limitKilometer: int.parse(_limitKilometers.text),
      months: int.parse(_months.text),
      policy: _policy.text,
      car: _selectedCar
    );
    WarrantyService.updateWarranty(warrantyForm, warranty!.warrantyId!).then((value) {
      if (value!) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('chỉnh sửa thành công'),
              backgroundColor: Colors.green,
            )
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Có lỗi xảy ra, vui lòng thử lại sau'),
              backgroundColor: Colors.red,
            )
        );
      }
    });
  }

  void NewWarranty() async {
    Warranty model = Warranty(
      name: _name.text,
      limitKilometer: int.parse(_limitKilometers.text),
      months: int.parse(_months.text),
      policy: _policy.text,
      car: _selectedCar
      //note: _note.text
    );
    WarrantyService.NewWarranty(model).then((value) {
      if (value!) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tạo gói bảo hành thành công'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Object Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  controller: _name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Limit Kilometers'),
                  keyboardType: TextInputType.number,
                  controller: _limitKilometers,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a limit in kilometers';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Months'),
                  keyboardType: TextInputType.number,
                  controller: _months,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the number of months';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Policy'),
                  controller: _policy,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a policy';
                    }
                    return null;
                  },

                ),
                // TextFormField(
                //   decoration: InputDecoration(labelText: 'Note'),
                //   controller: _note,
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter a policy';
                //     }
                //     return null;
                //   },
                // ),
                DropdownButtonFormField<Car>(
                  decoration: InputDecoration(labelText: 'Select a Car'),
                  value: _selectedCar,
                  items: cars.map((car) {
                    return DropdownMenuItem<Car>(
                      value: car,
                      child: Text(car.name!),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCar = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a car';
                    }
                    return null;
                  },
                ),
                warranty == null ?
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
        
                      NewWarranty();
                      // Clear the form
                      _formKey.currentState!.reset();
                    }
                  },
                  child: Text('Submit'),
                ) :
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
        
                      updateWarranty();
                      // Clear the form
                      _formKey.currentState!.reset();
                    }
                  },
                  child: Text('Change'),
                )
                ,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

