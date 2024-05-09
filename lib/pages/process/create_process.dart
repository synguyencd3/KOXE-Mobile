import 'package:flutter/material.dart';

class CreateObjectForm extends StatefulWidget {
  @override
  _CreateObjectFormState createState() => _CreateObjectFormState();
}

class _CreateObjectFormState extends State<CreateObjectForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  bool _reuse = false;
  String? _selectedObject;
  List<Map<String, dynamic>> _formCards = [];

  List<String> _objects = [
    'Object 1',
    'Object 2',
    'Object 3',
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, create the object
      String name = _nameController.text;
      String description = _descriptionController.text;

      Map<String, dynamic> object = {
        'name': name,
        'description': description,
        'reuse': _reuse,
        'selectedObject': _selectedObject,
        'formCards': _formCards,
      };

      // Print the created object
      print(object);

      // Reset the form
      _formKey.currentState!.reset();
      _nameController.clear();
      _descriptionController.clear();
      _reuse = false;
      _selectedObject = null;
      _formCards.clear();
    }
  }

  void _addFormCard() {
    setState(() {
      _formCards.add({
        'name': "",
        'order': "",
        'details': [],
      });
    });
  }

  void _addDetailField(int index) {
    setState(() {
      _formCards[index]['details']?.add(' ');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Object Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Text('Reuse: '),
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
              if (_reuse)
                DropdownButtonFormField<String>(
                  value: _selectedObject,
                  items: _objects.map((String object) {
                    return DropdownMenuItem<String>(
                      value: object,
                      child: Text(object),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedObject = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Select Object'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an object';
                    }
                    return null;
                  },
                ),
              TextButton(
                child: Text('Submit'),
                onPressed: () {
                  _submitForm();
                },
              ),
              SizedBox(height: 16.0),
              TextButton(
                child: Text('Add Form Card'),
                onPressed: () {
                  _addFormCard();
                },
              ),
              SizedBox(height: 16.0),
              ..._formCards.asMap().entries.map((entry) {
                int index = entry.key;
                //Map<String, List<String>> formCard = entry.value;
                var formCard = entry.value;
                //List<String> details = formCard['details']!;
                var details = formCard['details'];

                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Name'),
                          onChanged: (value) {
                            formCard['name']=value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Order'),
                          onChanged: (value) {
                            formCard['order'] = value;
                          },
                        ),
                        for (int i = 0; i < details.length; i++)
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Detail ${i + 1}'),
                            onChanged: (value) {
                              details[i] = value;
                            },
                          ),
                        TextButton(
                          child: Text('Add Detail Field'),
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