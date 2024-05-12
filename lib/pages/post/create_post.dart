import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/model/salon_model.dart';
import 'package:mobile/widgets/dropdown.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/services/post_service.dart';

import '../../model/car_model.dart';
import '../../model/post_model.dart';

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
  final ValueNotifier<String?> selectedValueNotifier =
      ValueNotifier<String>('');
  final picker = ImagePicker();
  late final TextEditingController _price = TextEditingController();
  late final TextEditingController _type = TextEditingController();
  late final TextEditingController _origin = TextEditingController();
  late final TextEditingController _brand = TextEditingController();
  late final TextEditingController _seat = TextEditingController();
  late final TextEditingController _kilometer = TextEditingController();
  late final TextEditingController _gear = TextEditingController();
  late final TextEditingController _mfg = TextEditingController();
  late final TextEditingController _color = TextEditingController();
  late final TextEditingController _text = TextEditingController();
  late final TextEditingController _accessory = TextEditingController();
  late final TextEditingController _registrationDeadline = TextEditingController();
  late final TextEditingController _address = TextEditingController();
  late final TextEditingController _version = TextEditingController();
  late final TextEditingController _fuel = TextEditingController();
  late final TextEditingController _licensePlate = TextEditingController();
  late final TextEditingController _ownerNumber = TextEditingController();
  late final TextEditingController _design = TextEditingController();

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

  Future<bool> createPost(String selectedSalonId) async {
    PostModel postModel = PostModel(
      text: _text.text,
      image: pickedFile?.map((e) => e.path).toList(),
      accessory: _accessory.text,
      registrationDeadline: _registrationDeadline.text,
      address: _address.text,
      fuel: _fuel.text,
      licensePlate: _licensePlate.text,
      ownerNumber: int.parse(_ownerNumber.text),
      color: _color.text,
      design: _design.text,
      salonId: selectedSalonId,
      car: Car(
          brand: _brand.text,
          type: _type.text,
          origin: _origin.text,
          model: _version.text,
          gear: _gear.text,
          mfg: _mfg.text,
          kilometer: int.parse(_kilometer.text),
          price: int.parse(_price.text),
          seat: int.parse(_seat.text)),
    );
    bool response = await PostService.createPost(postModel);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final _dropdownkey = GlobalKey();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tạo bài kết nối'),
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
                              padding: const EdgeInsets.all(30),
                              color: _backgroundColor,
                              child: Center(
                                  child: Column(
                                children: [
                                  const Icon(
                                    Icons.add_a_photo,
                                    size: 40,
                                  ),
                                  const Text(
                                    'Thêm ảnh xe',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ))),
                        )),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          if (image != null)
                            for (var i = 0; i < image!.length; i++)
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Image.file(
                                  image![i],
                                  width: 100,
                                  height: 100,
                                ),
                              )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _brand,
                      decoration: InputDecoration(
                        labelText: 'Hãng xe',
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
                        labelText: 'Dòng xe',
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
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _mfg,
                      decoration: InputDecoration(
                        labelText: 'Năm sản xuất',
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
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _version,
                      decoration: InputDecoration(
                        labelText: 'Phiên bản',
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
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _gear,
                      decoration: InputDecoration(
                        labelText: 'Hộp số',
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
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _fuel,
                      decoration: InputDecoration(
                        labelText: 'Nhiên liệu',
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
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _design,
                      decoration: InputDecoration(
                        labelText: 'Kiểu dáng',
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
                    const SizedBox(height: 20),
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
                        labelText: 'Số km đã đi',
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
                      controller: _color,
                      decoration: InputDecoration(
                        labelText: 'Màu sắc',
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
                      controller: _licensePlate,
                      decoration: InputDecoration(
                        labelText: 'Biển số xe',
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
                      controller: _ownerNumber,
                      decoration: InputDecoration(
                        labelText: 'Số chủ sở hữu',
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
                      controller: _accessory,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Phụ kiện đi kèm',
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
                    TextFormField(
                      controller: _price,
                      decoration: InputDecoration(
                        labelText: 'Giá',
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
                      controller: _registrationDeadline,
                      decoration: InputDecoration(
                        labelText: 'Hạn đăng kiểm',
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
                      controller: _address,
                      decoration: InputDecoration(
                        labelText: 'Địa chỉ hoa tiêu',
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
                controller: _text,
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
              FilledButton(
                  onPressed: () async {
                    String? selectedValue = selectedValueNotifier.value;
                    String? selectedSalonId = salons
                        .firstWhere((salon) => salon.name == selectedValue)
                        .salonId;
                    bool response = await createPost(selectedSalonId!);
                    if (response) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Đăng bài thành công'),backgroundColor: Colors.green,));
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Đăng bài thất bại'), backgroundColor: Colors.red,));
                    }
                    print(_mfg.text);
                  },
                  child: Text('Đăng bài'))
            ],
          ),
        ));
  }
}
