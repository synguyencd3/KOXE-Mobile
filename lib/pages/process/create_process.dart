import 'package:flutter/material.dart';
import 'package:mobile/model/document_model.dart';
import 'package:mobile/services/process_service.dart';

import '../../model/car_model.dart';
import '../../model/process_model.dart';
import '../../services/salon_service.dart';
import '../loading.dart';

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
  List<Document> _formCards = [];
  //List<Car> _cars = [];
  bool isLoading =false;
  process? _process;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, ()
    {
      initProcess();
    });
  }

  void initProcess() async {
    setState(() {
      isLoading = true;
    });
    try {
      var arg = ModalRoute
          .of(context)!
          .settings
          .arguments == null ? null : ModalRoute
          .of(context)!
          .settings
          .arguments as Map;
      setState(() {
        _process = arg?['process'];
      });
      _nameController.text = _process?.name ?? "";
      _descriptionController.text = _process?.description ?? "";
      if (_process != null) {
        setState(() {
          _formCards = _process!.documents!;
        });
        print(_formCards);
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void EditProcess() {

    process model = process(
        type: type,
        name: _nameController.text,
        description: _descriptionController.text,
        documents: _formCards
    );
    ProcessService.UpdateProcessName(model, _process!.id!).then((value) {
      if (value==true)
      {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Chỉnh sửa thành công'),
              backgroundColor: Colors.green,
            )
        );
        Navigator.pop(context);
      }
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String description = _descriptionController.text;
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
      ProcessService.NewProcess(model).then((value) {
        if (value!) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tạo thành công'),
                backgroundColor: Colors.green,
              )
          );
          Navigator.pop(context);
        }
      });
    }
  }

  void _addFormCard() {
    setState(() {
      _formCards.add(Document(details: []));
    });
  }

  void _addDetailField(int index) {
    setState(() {
      _formCards[index].details?.add(Details());
    });
  }

  void _deleteDetailField(Document formCard) {

      ProcessService.DeleteProcessDocument(formCard).then((value) {
        if (value!) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tạo thành công'),
                backgroundColor: Colors.green,
              )
          );
          Navigator.pop(context);
        }
      });

  }

  void _updateDetailField(Document formCard) {
    if (formCard.period == null) {
      ProcessService.CreateProcessDocument(formCard).then((value) {
        if (value!) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tạo thành công'),
                backgroundColor: Colors.green,
              )
          );
          Navigator.pop(context);
        }
      });
    }
    else {
      ProcessService.UpdateProcessDocument(formCard).then((value) {
        if (value!) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tạo thành công'),
                backgroundColor: Colors.green,
              )
          );
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo quy trình mới'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Tên quy trình'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập tên';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Mô tả'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập mô tả';
                  }
                  return null;
                },
              ),
 const SizedBox(height: 10),
 const Text('Quy trình áp dụng cho',style: TextStyle(fontWeight: FontWeight.bold),),
                Row(
                  children: [
                    Row(
                      children: [
                        const Text('Xe'),
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
                        const Text('Hoa tiêu'),
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

              _process == null ? TextButton(
                child: const Text('Tạo quy trình'),
                onPressed: () {
                  _submitForm();
                },
              ): TextButton(
                child: const Text('Cập nhật quy trình'),
                onPressed: () {
                  EditProcess();
                },
              ),
              TextButton(
                child: const Text('Thêm giai đoạn cho quy trình'),
                onPressed: () {
                  _addFormCard();
                },
              ),
              isLoading ? Loading() : Container(),
              const SizedBox(height: 16.0),
              ..._formCards.asMap().entries.map((entry) {
                int index = entry.key;
                var formCard = entry.value;
                var details = formCard.details;

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          initialValue: formCard.name,
                          decoration: const InputDecoration(labelText: 'Tên chi tiết'),
                          onChanged: (value) {
                            //formCard['name']=value;
                            formCard.name=value;
                          },
                        ),
                        TextFormField(
                          initialValue: '',
                          decoration: const InputDecoration(labelText: 'Độ ưu tiên'),
                          onChanged: (value) {
                            //formCard['order'] = value;
                            formCard.order=int.parse(value);
                          },
                        ),
                        for (int i = 0; i < details!.length; i++)
                          TextFormField(
                            initialValue: details[i].name,
                            decoration: InputDecoration(labelText: 'Detail ${i + 1}'),
                            onChanged: (value) {
                              details[i].name = value;
                            },
                          ),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              child: const Text('Thêm chi tiết cho giai đoạn'),
                              onPressed: () {
                                _addDetailField(index);
                              },
                            ),
                            _process == null ?  Container():
                            Row(
                              children: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    formCard.order = index;
                                    _updateDetailField(formCard);
                                  },
                                ),
                                IconButton(
                                  icon : Icon(Icons.delete),
                                  onPressed: () {
                                    formCard.order = index;
                                    _deleteDetailField(formCard);
                                  },
                                ),
                              ],
                            ),
                          ],
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