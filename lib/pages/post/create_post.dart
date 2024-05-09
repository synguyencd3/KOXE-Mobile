import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/model/salon_model.dart';
import 'package:mobile/widgets/dropdown.dart';
import 'package:mobile/services/salon_service.dart';

final _formKey = GlobalKey<FormState>();

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  Color? _backgroundColor = Colors.grey[300];
  double _titleSize = 20;
  double paddingSize = 10;
  List<File>? image;
  List<XFile>? pickedFile;
  final ValueNotifier<String?> selectedValueNotifier = ValueNotifier<String>('');
  final picker = ImagePicker();
  late final TextEditingController _name = TextEditingController();
  late final TextEditingController _description = TextEditingController();
  late final TextEditingController _price = TextEditingController();
  late final TextEditingController _type = TextEditingController();
  late final TextEditingController _origin = TextEditingController();
  late final TextEditingController _model = TextEditingController();
  late final TextEditingController _brand = TextEditingController();
  late final TextEditingController _capacity = TextEditingController();
  late final TextEditingController _door = TextEditingController();
  late final TextEditingController _seat = TextEditingController();
  late final TextEditingController _kilometer = TextEditingController();
  late final TextEditingController _gear = TextEditingController();
  late final TextEditingController _mfg = TextEditingController();
  late final TextEditingController _outColor = TextEditingController();

  List<Salon> salons = [];

  Future<void> pickImage() async {
    pickedFile = await picker.pickMultiImage();
    if (pickedFile != null) {
      setState(() {
        image = pickedFile!.map((e) => File(e.path)).toList();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getAllSalons();
    });
  }

  Future<void> getAllSalons() async {
    List<Salon> salonsAPI = await SalonsService.getAll();
    setState(() {
      salons = salonsAPI;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _dropdownkey = GlobalKey();
    return Scaffold(
        appBar: AppBar(
          title: Text('Tạo bài kết nối'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        padding: EdgeInsets.all(paddingSize),
                        color: _backgroundColor,
                        child: Text(
                          'THÔNG TIN XE',
                          style: TextStyle(fontSize: _titleSize),
                        )),
                    DottedBorder(
                        color: Colors.black,
                        strokeWidth: 1,
                        child: GestureDetector(
                          onTap: () => pickImage(),
                          child: Container(
                              padding: EdgeInsets.all(30),
                              color: _backgroundColor,
                              child: Center(
                                  child: Column(
                                children: [
                                  Icon(
                                    Icons.add_a_photo,
                                    size: 40,
                                  ),
                                  Text(
                                    'Thêm ảnh xe',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ))),
                        )),
                    TextFormField(
                      controller: _name,
                      decoration: InputDecoration(
                        labelText: 'Tên xe',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            //  color: Color(0xFF6F61EF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _price,
                      decoration: InputDecoration(
                        labelText: 'giá',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Color(0xFF6F61EF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _type,
                      decoration: InputDecoration(
                        labelText: 'Loại',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Color(0xFF6F61EF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _origin,
                      decoration: InputDecoration(
                        labelText: 'Xuất xứ',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Color(0xFF6F61EF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _model,
                      decoration: InputDecoration(
                        labelText: 'Model',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Color(0xFF6F61EF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _brand,
                      decoration: InputDecoration(
                        labelText: 'Hãng',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Color(0xFF6F61EF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _capacity,
                      decoration: InputDecoration(
                        labelText: 'Dung tích',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Color(0xFF6F61EF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _door,
                      decoration: InputDecoration(
                        labelText: 'Số cửa',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Color(0xFF6F61EF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _seat,
                      decoration: InputDecoration(
                        labelText: 'Số chỗ ngồi',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Color(0xFF6F61EF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _kilometer,
                      decoration: InputDecoration(
                        labelText: 'Odo',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Color(0xFF6F61EF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _gear,
                      decoration: InputDecoration(
                        labelText: 'Số',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Color(0xFF6F61EF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _mfg,
                      decoration: InputDecoration(
                        labelText: 'tiêu hao nhiên liệu/lít',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Color(0xFF6F61EF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _outColor,
                      decoration: InputDecoration(
                        labelText: 'Màu ngoại thất',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Color(0xFF6F61EF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _description,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Giới thiệu',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(16, 24, 16, 12),
                      ),
                      maxLines: 16,
                      minLines: 6,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding: EdgeInsets.all(paddingSize),
                        color: _backgroundColor,
                        child: Text('THÔNG TIN SALON KẾT NỐI',
                            style: TextStyle(fontSize: _titleSize))),
                  ],
                ),
              ),
              salons.isNotEmpty
                  ? DropdownMenuExample(
                      key: _dropdownkey,
                      width: 400,
                      valueNotifier: selectedValueNotifier,
                      items: salons
                          .map((e) => e.name)
                          .where((name) => name != null)
                          .toList()
                          .cast<String>(),
                    )
                  : Container(),
              TextField(
                controller: _description,
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Lời nhắn cho salon',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding:
                  EdgeInsetsDirectional.fromSTEB(16, 24, 16, 12),
                ),
                maxLines: 16,
                minLines: 6,
              ),
              FilledButton(onPressed: () {
                String? selectedValue = selectedValueNotifier.value;
                String? selectedSalonId = salons.firstWhere((salon) => salon.name == selectedValue)?.salonId;
                print(selectedSalonId);
                print(_mfg.text);
              }, child: Text('Đăng bài'))
            ],
          ),
        ));
  }
}
