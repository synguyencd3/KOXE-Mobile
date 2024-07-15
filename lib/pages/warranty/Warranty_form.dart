import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/services/warranty_service.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../model/car_model.dart';
import '../../model/maintaince_model.dart';
import '../../model/warranty_model.dart';
import '../../services/maintaince_service.dart';



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
  bool _showDropdown = false;
  Car? _selectedCar;
  List<MaintainceModel> maintainces = [];
  final MultiSelectController _controller = MultiSelectController();

  Warranty? warranty;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getAllMaintainces();
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

  void getAllMaintainces() async {
    List<MaintainceModel> maintaincesAPI =
    await MaintainceService().getAllMaintainces();
    print(maintaincesAPI.length);
    maintainces = maintaincesAPI;
  }

  void initWarranty() {
    try {
      var data = ModalRoute
          .of(context)!
          .settings
          .arguments as Map;
      setState(() {
        warranty = data['warranty'];
       // _controller.setOptions(warranty?.maintenance!.map((e) => ValueItem(label: e.name, value: e.id)).toList() ?? []);
       _controller.setOptions(maintainces.map((e) => ValueItem(label: e.name, value: e.id)).toList());
       
        _controller.setSelectedOptions()
      });
      print(jsonEncode(warranty));
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
   //   car: _selectedCar
    );
    var maintenanceList = _controller.selectedOptions.map((e) => e.value).toList();
    WarrantyService.updateWarranty(warrantyForm, warranty!.warrantyId!, maintenanceList).then((value) {
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
      reuse: _showDropdown,
     // car: _selectedCar
      //note: _note.text
    );
    var maintenanceList = _controller.selectedOptions.map((e) => e.value).toList();
    WarrantyService.NewWarranty(model, maintenanceList).then((value) {
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
        title: Text('Thêm gói bảo hành'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Tên gói bảo hành'),
                  controller: _name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng không bỏ trống';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Số kilometer giới hạn'),
                  keyboardType: TextInputType.number,
                  controller: _limitKilometers,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng không bỏ trống';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Số tháng bảo hành'),
                  keyboardType: TextInputType.number,
                  controller: _months,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng không bỏ trống';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Chính sách'),
                  controller: _policy,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng không bỏ trống';
                    }
                    return null;
                  },

                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Các gói bảo dưỡng đi kèm'),
                  enabled: false,
                  readOnly: true,
                ),
                MultiSelectDropDown(
                  showClearIcon: true,
                  controller: _controller,
                  borderRadius: 0,

                  onOptionSelected: (options) {
                    debugPrint(options.toString());
                  },
                  options: maintainces.map((e) => ValueItem(label: e.name, value: e.id)).toList(),
                  selectionType: SelectionType.multi,
                  chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                  dropdownHeight: 300,
                  optionTextStyle: const TextStyle(fontSize: 16),
                  selectedOptionIcon: const Icon(Icons.check_circle),
                ),
                CheckboxListTile(
                  value: _showDropdown,
                  title: const Text('Sử dụng riêng cho xe bất kì'),
                  onChanged: (value) {
                    setState(() {
                      _showDropdown = value!;
                    });
                  },
                ),
                _showDropdown ?
                DropdownButtonFormField<Car>(
                  decoration: InputDecoration(labelText: 'Chọn xe'),
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
                ) : Container(),
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
                  child: Text('Tạo'),
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

