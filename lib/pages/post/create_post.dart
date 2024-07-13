import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/model/salon_model.dart';
import 'package:mobile/widgets/dropdown.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/services/post_service.dart';
import '../../model/salon_group_model.dart';
import '../../services/salon_group_service.dart';

import '../../model/car_model.dart';
import '../../model/post_model.dart';
import '../../services/salon_group_service.dart';

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
  final ValueNotifier<String?> selectedValueAccessory =
      ValueNotifier<String>('');
  final ValueNotifier<String?> selectedValueRegistration =
      ValueNotifier<String>('');
  final ValueNotifier<String> selectedValueGear = ValueNotifier<String>('');
  final ValueNotifier<String> selectedValueFuel = ValueNotifier<String>('');
  final picker = ImagePicker();
  late final TextEditingController _price = TextEditingController();
  late final TextEditingController _type = TextEditingController();
  late final TextEditingController _origin = TextEditingController();
  late final TextEditingController _brand = TextEditingController();
  late final TextEditingController _seat = TextEditingController();
  late final TextEditingController _kilometer = TextEditingController();
  late final TextEditingController _mfg = TextEditingController();
  late final TextEditingController _color = TextEditingController();
  late final TextEditingController _text = TextEditingController();
  late final TextEditingController _address = TextEditingController();
  late final TextEditingController _version = TextEditingController();
  late final TextEditingController _licensePlate = TextEditingController();
  late final TextEditingController _ownerNumber = TextEditingController();
  late final TextEditingController _design = TextEditingController();
  late final TextEditingController _title = TextEditingController();

  List<Salon> salons = [];
  static const double _distanceSize = 20.0;
  List<String> _booleanValues = ['Có', 'Không'];
  List<String> _gearValues = ['Số tự động', 'Số sàn', 'Bán tự động'];
  List<String> _fuelValues = ['Xăng', 'Dầu', 'Điện', 'Hybrid'];
  List<String> selectedSalonIds = [];
  List<SalonGroupModel> salonGroups = [];

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
      getAllGroups();
    });
    selectedSalonIds = [];
  }

  @override
  void dispose() {
    _price.dispose();
    _type.dispose();
    _origin.dispose();
    _brand.dispose();
    _seat.dispose();
    _kilometer.dispose();
    _mfg.dispose();
    _color.dispose();
    _text.dispose();
    _address.dispose();
    _version.dispose();
    _licensePlate.dispose();
    _ownerNumber.dispose();
    _design.dispose();
    _title.dispose();
    super.dispose();
  }

  Future<void> getAllSalons() async {
    List<Salon> salonsAPI = await SalonsService.getSalonNoBlock();
    if (mounted) {
      setState(() {
        salons = salonsAPI;
      });
    }
  }

  Future<void> getAllGroups() async {
    List<SalonGroupModel> salonGroupsAPI =
        await SalonGroupService.getAllGroups();
    setState(() {
      salonGroups = salonGroupsAPI;
    });
  }

  Future<bool> createPost() async {
    //print(selectedSalonIds);
    PostModel postModel = PostModel(
      title: _title.text,
      text: _text.text,
      image: pickedFile?.map((e) => e.path).toList(),
      accessory: selectedValueAccessory.value == 'Có' ? true : false,
      registrationDeadline:
          selectedValueRegistration.value == 'Có' ? true : false,
      address: _address.text,
      fuel: selectedValueFuel.value,
      licensePlate: _licensePlate.text,
      ownerNumber: _ownerNumber.text != '' ? int.parse(_ownerNumber.text) : 0,
      color: _color.text,
      design: _design.text,
      salonId: selectedSalonIds,
      car: Car(
          brand: _brand.text,
          type: _type.text,
          origin: _origin.text,
          model: _version.text,
          gear: selectedValueGear.value,
          mfg: _mfg.text,
          kilometer: _kilometer.text != '' ? int.parse(_kilometer.text) : 0,
          price: _price.text != '' ? int.parse(_price.text) : 0,
          seat: _seat.text != '' ? int.parse(_seat.text) : 0),
    );
    //return true;
    bool response = await PostService.createPost(postModel);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tạo bài kết nối'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      const SizedBox(height: _distanceSize),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
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
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
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
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
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
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
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
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
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
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
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
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Phụ kiện đi kèm'),
                                DropdownMenuExample(
                                    valueNotifier: selectedValueAccessory,
                                    items: _booleanValues),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hạn đăng kiểm'),
                                DropdownMenuExample(
                                    valueNotifier: selectedValueRegistration,
                                    items: _booleanValues),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hộp số'),
                                DropdownMenuExample(
                                    valueNotifier: selectedValueGear,
                                    items: _gearValues),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nhiên liệu'),
                                DropdownMenuExample(
                                    valueNotifier: selectedValueFuel,
                                    items: _fuelValues),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                          padding: EdgeInsets.all(paddingSize),
                          color: _backgroundColor,
                          child: Text('THÔNG TIN HOA TIÊU',
                              style: TextStyle(fontSize: _titleSize))),
                      const SizedBox(height: 20),
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
                          child: Text('THÔNG TIN BÀI KẾT NỐI',
                              style: TextStyle(fontSize: _titleSize))),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _title,
                  decoration: InputDecoration(
                    labelText: 'Tiêu đề bài kết nối',
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
                TextField(
                  controller: _text,
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
                const SizedBox(height: 20),
                FilledButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: Text('Chọn từng salon'),
                                    trailing: Icon(Icons.arrow_forward),
                                    onTap: () {
                                      Navigator.pop(context);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(builder:
                                                (context,
                                                    StateSetter setState) {
                                              return AlertDialog(
                                                title: Text('Chọn salon'),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: salons.map((salon) {
                                                    return CheckboxListTile(
                                                      title: Text(salon.name!),
                                                      value: selectedSalonIds
                                                          .contains(
                                                              salon.salonId),
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          if (value == true) {
                                                            selectedSalonIds
                                                                .add(salon
                                                                    .salonId!);
                                                          } else {
                                                            selectedSalonIds
                                                                .remove(salon
                                                                    .salonId);
                                                          }
                                                        });
                                                      },
                                                    );
                                                  }).toList(),
                                                ),
                                                actions: [
                                                  TextButton(onPressed: (){
                                                    Navigator.pop(context);
                                                  }, child: Text('Hủy')),
                                                  TextButton(
                                                    child: Text('OK'),
                                                    onPressed: () async {
                                                      bool response =
                                                          await createPost();
                                                      if (response) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              'Đăng bài thành công'),
                                                          backgroundColor:
                                                              Colors.green,
                                                        ));
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              'Đăng bài thất bại'),
                                                          backgroundColor:
                                                              Colors.red,
                                                        ));
                                                      }
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                          });
                                    },
                                  ),
                                  ListTile(
                                    title: Text('Chọn nhóm salon'),
                                    trailing: Icon(Icons.arrow_forward),
                                    onTap: () {
                                      Navigator.pop(context);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(builder:
                                                (context,
                                                    StateSetter setState) {
                                              return AlertDialog(
                                                title: Text('Chọn nhóm salon'),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children:
                                                      salonGroups.map((group) {
                                                    return CheckboxListTile(
                                                      title: Text(group.name),
                                                      value: group.salons!
                                                          .every((salon) =>
                                                              selectedSalonIds
                                                                  .contains(
                                                                      salon
                                                                          .id)),
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          if (value == true) {
                                                            group.salons
                                                                ?.forEach(
                                                                    (salon) {
                                                              if (!selectedSalonIds
                                                                  .contains(salon
                                                                      .id)) {
                                                                selectedSalonIds
                                                                    .add(salon
                                                                        .id);
                                                              }
                                                            });
                                                          } else {
                                                            group.salons
                                                                ?.forEach(
                                                                    (salon) {
                                                              selectedSalonIds
                                                                  .remove(
                                                                      salon.id);
                                                            });
                                                          }
                                                        });
                                                      },
                                                    );
                                                  }).toList(),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Hủy')),
                                                  TextButton(
                                                    child: Text('OK'),
                                                    onPressed: () async {
                                                      bool response =
                                                          await createPost();
                                                      if (response) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              'Đăng bài thành công'),
                                                          backgroundColor:
                                                              Colors.green,
                                                        ));
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              'Đăng bài thất bại'),
                                                          backgroundColor:
                                                              Colors.red,
                                                        ));
                                                      }
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                          });
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: Text('Đăng bài'))
              ],
            ),
          ),
        ));
  }
}
