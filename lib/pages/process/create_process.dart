import 'package:flutter/material.dart';
import 'package:mobile/model/document_model.dart';
import 'package:mobile/services/process_service.dart';

import '../../model/car_model.dart';
import '../../model/process_model.dart';
import '../../services/salon_service.dart';

class NewProcess extends StatefulWidget {
  @override
  _NewProcessState createState() => _NewProcessState();
}

class _NewProcessState extends State<NewProcess> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  bool _reuse = false;
  Car? _selectedObject;
  int type=0;
  //List<Map<String, dynamic>> _formCards = [];
  List<Document> _formCards = [];

  // List<String> _objects = [
  //   'Object 1',
  //   'Object 2',
  //   'Object 3',
  // ];

  List<Car> _objects = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCars();
  }

  void initCars() async {
    var salonId = await SalonsService.isSalon();
    var data = await SalonsService.getDetail(salonId);
    setState(() {
      _objects = data;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, create the object
      String name = _nameController.text;
      String description = _descriptionController.text;

      // Map<String, dynamic> object = {
      //   'name': name,
      //   'description': description,
      //   'reuse': _reuse,
      //   'selectedObject': _selectedObject,
      //   'formCards': _formCards,
      // };

      process model;

      if (_reuse) {
        model  = process(
            type: type,
            name: _nameController.text,
            carId: _selectedObject?.id,
            description: _descriptionController.text,
            documents: _formCards
        );
      }
      else {
        model = process(
            type: type,
            name: _nameController.text,
            description: _descriptionController.text,
            documents: _formCards
        );
      }

      // Print the created object
      //print(object);
      ProcessService.NewProcess(model).then((value) {
        if (value!) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Tạo thành công'),
                backgroundColor: Colors.green,
              )
          );
          Navigator.pop(context);
        }
      });
      // Reset the form
      // _formKey.currentState!.reset();
      // _nameController.clear();
      // _descriptionController.clear();
      // _reuse = false;
      // _selectedObject = null;
     // _formCards.clear();
    }
  }

  void _addFormCard() {
    setState(() {
      // _formCards.add({
      //   'name': "",
      //   'order': "",
      //   'details': [],
      // });
      _formCards.add(Document(details: []));
    });
  }

  void _addDetailField(int index) {
    setState(() {
      //_formCards[index]['details']?.add(' ');
      _formCards[index].details?.add(Details());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo quy trình mới'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Tên quy trình'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập tên';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Mô tả'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập mô tả';
                  }
                  return null;
                },
              ),
 const SizedBox(height: 10),
 Text('Quy trình áp dụng cho',style: TextStyle(fontWeight: FontWeight.bold),),
                Row(
                  children: [
                    Row(
                      children: [
                        Text('Xe'),
                        Radio<int>(
                          value: 0,
                          groupValue: type,
                          onChanged: (int? value) {
                            setState(() {
                              type = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Hoa tiêu'),
                        Radio<int>(
                          value: 1,
                          groupValue: type,
                          onChanged: (int? value) {
                            setState(() {
                              type = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),

              Row(
                children: [
                  Text('Sử dụng lại: '),
                  Checkbox(
                    value: _reuse,
                    onChanged: (value) {
                      setState(() {
                        _reuse = value!;
                      });
                    },
                  ),
                ],
              ),
              if (!_reuse)
                DropdownButtonFormField<Car>(
                  value: _selectedObject,
                  items: _objects.map((Car object) {
                    return DropdownMenuItem<Car>(
                      value: object,
                      child: Text(object.name!),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedObject = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Chọn xe áp dụng'),
                  validator: (value) {
                    if (value == null) {
                      return 'Vui lòng chọn xe';
                    }
                    return null;
                  },
                ),
              TextButton(
                child: Text('Tạo quy trình'),
                onPressed: () {
                  _submitForm();
                },
              ),
              TextButton(
                child: Text('Thêm giai đoạn cho quy trình'),
                onPressed: () {
                  _addFormCard();
                },
              ),
              SizedBox(height: 16.0),
              ..._formCards.asMap().entries.map((entry) {
                int index = entry.key;
                var formCard = entry.value;
                var details = formCard.details;

                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Tên chi tiết'),
                          onChanged: (value) {
                            //formCard['name']=value;
                            formCard.name=value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Độ ưu tiên'),
                          onChanged: (value) {
                            //formCard['order'] = value;
                            formCard.order=int.parse(value);
                          },
                        ),
                        for (int i = 0; i < details!.length; i++)
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Detail ${i + 1}'),
                            onChanged: (value) {
                              details[i].name = value;
                            },
                          ),
                        TextButton(
                          child: Text('Thêm chi tiết cho giai đoạn'),
                          onPressed: () {
                            _addDetailField(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}