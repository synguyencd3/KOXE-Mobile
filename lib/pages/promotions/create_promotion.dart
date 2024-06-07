import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

Widget preview() {
    return NewObjectForm();
}

class NewObjectForm extends StatefulWidget {
  @override
  _NewObjectFormState createState() => _NewObjectFormState();
}

class _NewObjectFormState extends State<NewObjectForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contentHtmlController = TextEditingController();
  final TextEditingController _contentMarkdownController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  File? _bannerImage;

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != (isStartDate ? _startDate : _endDate)) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _bannerImage = File(image.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with creating the new object
      final newObject = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'contentHtml': _contentHtmlController.text,
        'contentMarkdown': _contentMarkdownController.text,
        'startDate': _startDate,
        'endDate': _endDate,
        'banner': _bannerImage,
      };

      // Handle form submission (e.g., send to a server or save locally)
      print('Form submitted successfully: $newObject');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Object'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentHtmlController,
                decoration: InputDecoration(labelText: 'Content (HTML)'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter HTML content';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentMarkdownController,
                decoration: InputDecoration(labelText: 'Content (Markdown)'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Markdown content';
                  }
                  return null;
                },
              ),
              ListTile(
                title: Text(_startDate == null
                    ? 'Start Date: Not selected'
                    : 'Start Date: ${_startDate!.toLocal()}'.split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _pickDate(context, true),
              ),
              ListTile(
                title: Text(_endDate == null
                    ? 'End Date: Not selected'
                    : 'End Date: ${_endDate!.toLocal()}'.split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _pickDate(context, false),
              ),
              ListTile(
                title: Text('Banner Image'),
                trailing: Icon(Icons.image),
                onTap: _pickImage,
              ),
              _bannerImage == null
                  ? Text('No image selected.')
                  : Image.file(_bannerImage!),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}