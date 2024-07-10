import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile/model/promotion_request.dart';
import 'package:mobile/pages/news/PromotionArticle.dart';
import 'package:mobile/services/news_service.dart';
import 'package:mobile/services/promotion_service.dart';

import '../../model/promotion_article_model.dart';

class NewPromotion extends StatefulWidget {
  NewPromotion({this.id});

  @override
  _NewPromotionState createState() => _NewPromotionState();
  late final String? id;
}

class _NewPromotionState extends State<NewPromotion> {
  final _formKey = GlobalKey<FormState>();
  late final PromotionArticleModel? promotion;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  //final TextEditingController _contentHtmlController = TextEditingController();
  final TextEditingController _contentMarkdownController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  List<File>? image;
  List<XFile>? pickedFile;
  final picker = ImagePicker();


  Future<void> GetPromotion() async {
    var data = await NewsService.getPromotion(widget.id!);
    setState(() {
      promotion=data;
    });
    
    _titleController.text = promotion?.title ?? "";
    _descriptionController.text = promotion?.description ?? "";
    _contentMarkdownController.text = promotion?.contentMarkdown ?? "";
    _startDate = new DateFormat("dd/MM/yyyy").parse(promotion!.startDate!);//DateTime.parse(promotion!.startDate!);
    _endDate = new DateFormat("dd/MM/yyyy").parse(promotion!.endDate!);
  }

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
        startDate: '${_startDate?.year}-${_startDate?.month}-${_startDate?.day}',
        endDate: '${_endDate?.year}-${_endDate?.month}-${_endDate?.day}',
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

  void _changeForm() {
    PromotionRequest promotion = PromotionRequest(
        title: _titleController.text,
        description: _descriptionController.text,
        contentMarkdown: _contentMarkdownController.text,
        startDate: '${_startDate?.year}-${_startDate?.month}-${_startDate
            ?.day}',
        endDate: '${_endDate?.year}-${_endDate?.month}-${_endDate?.day}',
        banner: pickedFile?.map((e) => e.path).toList()
    );
    PromotionService.ChangePromotion(promotion, widget.id!).then((value) {
      if (value == true) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('sửa thành công'),
              backgroundColor: Colors.green,
            )
        );
        Navigator.pop(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.id!= null) GetPromotion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo khuyến mãi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                //initialValue: promotion == null ? "" :promotion?.title?? "",
                decoration: InputDecoration(labelText: 'Tiêu đề'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng điền tiêu đề';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Mô tả'),
                //initialValue: promotion == null ? "" :promotion?.description ?? "",
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng điền mô tả';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentMarkdownController,
                decoration: InputDecoration(labelText: 'Nội dung (Dạng markdown)'),
                //initialValue: promotion == null ? "" :promotion?.contentMarkdown ?? "",
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng điền nội dung';
                  }
                  return null;
                },
              ),
              ListTile(
                title: Text(_startDate == null
                    ? 'Ngày bắt đầu: Chưa chọn'
                    : 'Ngày bắt đầu: ${_startDate!.toLocal()}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _pickDate(context, true),
              ),
              ListTile(
                title: Text(_endDate == null
                    ? 'Ngày kết thúc: Chưa chọn'
                    : 'Ngày kết thúc: ${_endDate!.toLocal()}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _pickDate(context, false),
              ),
              ListTile(
                title: Text('Ảnh banner'),
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
              widget.id != null ? ElevatedButton(
                onPressed: _changeForm,//_submitForm,
                child: Text('Change'),
              ): ElevatedButton(
                onPressed: _submitForm,
                child: Text('Tạo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}