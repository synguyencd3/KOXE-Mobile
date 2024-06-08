import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/model/promotion_request.dart';
import 'package:mobile/services/promotion_service.dart';

class NewPromotion extends StatefulWidget {
  @override
  _NewPromotionState createState() => _NewPromotionState();
}

class _NewPromotionState extends State<NewPromotion> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contentHtmlController = TextEditingController();
  final TextEditingController _contentMarkdownController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  List<File>? image;
  List<XFile>? pickedFile;
  final picker = ImagePicker();

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

  Future<void> pickImage() async {
    pickedFile =  await picker.pickMultiImage();
    if (pickedFile !=null) {
      setState(() {
        image = pickedFile!.map((e) => File(e.path)).toList();
      });
    }
  }

  void _submitForm() {
      PromotionRequest promotion = PromotionRequest(
        title: _titleController.text,
        description: _descriptionController.text,
        contentMarkdown: _contentMarkdownController.text,
        startDate: '${_startDate?.day}/${_startDate?.month}/${_startDate?.year}',
        endDate: '${_endDate?.day}/${_endDate?.month}/${_endDate?.year}',
        banner: pickedFile?.map((e) => e.path).toList()
      );
      PromotionService.NewPromotion(promotion).then((value) {
        if (value==true)
        {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Tạo thành công'),
                backgroundColor: Colors.green,
              )
          );
          Navigator.pop(context);
        }
      });
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
                onTap: () =>pickImage(),
              ),
              Container(
                  width: double.infinity,
                  child: pickedFile==null
                      ? const Text('Vui lòng chọn ảnh')
                      : Text('${pickedFile!.length} ảnh đã chọn')
              ),
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