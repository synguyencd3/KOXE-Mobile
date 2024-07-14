import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/services/warranty_service.dart';

import '../../model/car_model.dart';
import '../../model/warranty_model.dart';
import '../../services/cars_service.dart';
import '../../utils/utils.dart';
import '../loading.dart';

class EditCar extends StatefulWidget {
  const EditCar({super.key});

  @override
  State<EditCar> createState() => _EditCarState();
}

class _EditCarState extends State<EditCar> {
  Car? car;
  bool isLoading = false;

  //late final PageController pageController;
  List<File>? image;
  List<XFile>? pickedFile;
  final picker = ImagePicker();
  List<Warranty> warranties = [];
  Warranty? selectedWarranty;
  DateTime time = DateTime.now().subtract(const Duration(days: 30));

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

  //late final TextEditingController _mfg  = TextEditingController();
  late final TextEditingController _outColor = TextEditingController();

  Future<void> pickImage() async {
    pickedFile = await picker.pickMultiImage();
    if (pickedFile != null) {
      setState(() {
        image = pickedFile!.map((e) => File(e.path)).toList();
      });
    }
  }

  void NewCar() {
    Car car = Car(
        name: _name.text,
        description: _description.text,
        price: int.parse(_price.text),
        type: _type.text,
        origin: _origin.text,
        model: _model.text,
        brand: _brand.text,
        capacity: double.parse(_capacity.text),
        door: int.parse(_door.text),
        seat: int.parse(_seat.text),
        kilometer: int.parse(_kilometer.text),
        gear: _gear.text,
        mfg: time.toString(),
        outColor: _outColor.text,
        image: pickedFile?.map((e) => e.path).toList());

    CarsService.NewCar(car, selectedWarranty?.warrantyId ).then((value) {
      if (value == true) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Tạo thành công'),
          backgroundColor: Colors.green,
        ));
        Navigator.pop(context);
      }
    });
  }

  void EditCar() {
    Car carForm = Car(
        name: _name.text,
        description: _description.text,
        price: int.parse(_price.text),
        type: _type.text,
        origin: _origin.text,
        model: _model.text,
        brand: _brand.text,
        capacity: double.parse(_capacity.text),
        door: int.parse(_door.text),
        seat: int.parse(_seat.text),
        kilometer: int.parse(_kilometer.text),
        gear: _gear.text,
        mfg: time.toString(),
        //_mfg.text,
        outColor: _outColor.text,
        image: pickedFile?.map((e) => e.path).toList());
    if (selectedWarranty != null)
      WarrantyService.pushWarranty(selectedWarranty!.warrantyId!, car!.id!);
    CarsService.EditCar(carForm, car!.id!, selectedWarranty?.warrantyId).then((value) {
      if (value == true) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Chỉnh sửa thành công'),
          backgroundColor: Colors.green,
        ));
        Navigator.pop(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      initCar();
    });
  }

  void initCar() async {
    setState(() {
      isLoading = true;
    });
    //var data = ModalRoute.of(context)!.settings.arguments as Map;
    var arg = ModalRoute.of(context)!.settings.arguments == null
        ? null
        : ModalRoute.of(context)!.settings.arguments as Map;
    Car? oldCar = arg?['car'];
    var warrantyData = await WarrantyService.getAll();
    warrantyData = warrantyData.where((element) => element.reuse==true).toList();
    Car? data = oldCar == null ? null : await CarsService.getDetail(oldCar.id!);
    print('set state');
    setState(() {
      car = data;
      warranties = warrantyData;
      isLoading = false;
    });
    _name.text = car?.name ?? "";
    _description.text = car?.description ?? "";
    _price.text = car?.price.toString() ?? "";
    _brand.text = car?.brand ?? carBrands[0];
    _origin.text = car?.origin ?? "";
    _model.text = car?.origin ?? "";
    _type.text = car?.type ?? carTypes[0];
    _capacity.text = car?.capacity.toString() ?? "";
    _door.text = car?.door.toString() ?? "";
    _seat.text = car?.seat.toString() ?? "";
    _kilometer.text = car?.kilometer.toString() ?? "";
    _gear.text = car?.gear ?? "";
    //_mfg.text = car?.mfg ?? "";
    _outColor.text = car?.outColor ?? "";
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: time,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != time) {
      setState(() {
        time = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Thêm xe',
            //   style: FlutterFlowTheme.of(context).titleLarge.override(
            //   fontFamily: 'Outfit',
            //   color: Color(0xFF15161E),
            //   fontSize: 22,
            //   fontWeight: FontWeight.w500,
            // ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: isLoading ? [Loading()] :[
                TextFormField(
                  controller: _name,
                  decoration: InputDecoration(
                    labelText: 'Tên xe',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        //  color: Color(0xFF6F61EF),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _price,
                  decoration: InputDecoration(
                    labelText: 'Giá',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        // color: Color(0xFF6F61EF),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // TextFormField(
                //   controller: _type,
                //   decoration: InputDecoration(
                //     labelText: 'Loại',
                //     enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(12)),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: const BorderSide(
                //         // color: Color(0xFF6F61EF),
                //         width: 2,
                //       ),
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //   ),
                // ),

                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Dòng xe',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  value: car==null? carTypes[0] : _type.text,
                  items: carTypes.map((String brand) {
                    return DropdownMenuItem<String>(
                      value: brand,
                      child: Text(brand),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _type.text = newValue ?? "";
                    });
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: _origin,
                  decoration: InputDecoration(
                    labelText: 'Xuất xứ',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        // color: Color(0xFF6F61EF),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // TextFormField(
                //   controller: _brand,
                //   decoration: InputDecoration(
                //     labelText: 'Hãng',
                //     enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(12)),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: BorderSide(
                //         // color: Color(0xFF6F61EF),
                //         width: 2,
                //       ),
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //   ),
                // ),

                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Hãng xe',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  value: car==null? carBrands[0] :_brand.text,
                  items: carBrands.map((String brand) {
                    return DropdownMenuItem<String>(
                      value: brand,
                      child: Text(brand),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _brand.text = newValue ?? "";
                    });
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: _capacity,
                  decoration: InputDecoration(
                    labelText: 'Dung tích',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        // color: Color(0xFF6F61EF),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: _door,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Số cửa',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
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
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Số chỗ ngồi',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        // color: Color(0xFF6F61EF),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: _kilometer,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Số km đã đi',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
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
                      borderSide: const BorderSide(
                        // color: Color(0xFF6F61EF),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // TextFormField(
                //   controller: _mfg,
                //   decoration: InputDecoration(labelText: 'Năm sản xuất',
                //     enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(12)
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: BorderSide(
                //         // color: Color(0xFF6F61EF),
                //         width: 2,
                //       ),
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //   ),
                // ),
                GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Row(
                      children: [
                        Text(
                            'Năm sản xuất: ${time.day}/${time.month}/${time.year}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 10),
                        const Icon(Icons.edit),
                      ],
                    )),

                const SizedBox(height: 20),

                TextFormField(
                  controller: _outColor,
                  decoration: InputDecoration(
                    labelText: 'Màu ngoại thất',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        // color: Color(0xFF6F61EF),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

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
                      borderSide: const BorderSide(
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding:
                        const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 12),
                  ),
                  // style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //       fontFamily: 'Plus Jakarta Sans',
                  //       color: Color(0xFF15161E),
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  maxLines: 16,
                  minLines: 6,
                ),

                const SizedBox(
                  height: 20,
                ),

                GestureDetector(
                  onTap: () => pickImage(),
                  child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(
                          maxWidth: 500,
                        ),
                        decoration: BoxDecoration(
                          //color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            //color: Color(0xFFE5E7EB),
                            width: 1,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.add_a_photo_rounded,
                                size: 32,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                child: Text(
                                  'Chọn hình ảnh',
                                  textAlign: TextAlign.center,
                                  // style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  //       fontFamily: 'Plus Jakarta Sans',
                                  //       color: Color(0xFF15161E),
                                  //       fontSize: 14,
                                  //       fontWeight: FontWeight.w500,
                                  //     ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),

                const SizedBox(height: 20),

                Container(
                    width: double.infinity,
                    child: pickedFile == null
                        ? const Text('Vui lòng chọn ảnh')
                        : Text('${pickedFile!.length} ảnh đã chọn')),

                const SizedBox(height: 20),

                DropdownButtonFormField<Warranty>(
                    decoration: InputDecoration(
                      labelText: 'Bảo hành',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    value: selectedWarranty,
                    items: warranties.map((warranty) {
                      return DropdownMenuItem<Warranty>(
                        value: warranty,
                        child: Text(warranty.name!),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedWarranty = value;
                      });
                    }),
                car == null
                    ? Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                        child: OutlinedButton(
                          child: const Text('Thêm xe'),
                          onPressed: () {
                            NewCar();
                          },
                        ),

                        // child: FFButtonWidget(text: "Tạo salon", onPressed: () {
                        //   NewSalon();
                        // }, options:
                        //   FFButtonOptions(
                        //   height: 40,
                        //   width: 200,
                        //   padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        //   iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        //   color: FlutterFlowTheme.of(context).primary,
                        //   textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        //         fontFamily: 'Readex Pro',
                        //         color: Colors.white,
                        //       ),
                        //   elevation: 3,
                        //   borderSide: BorderSide(
                        //     color: Colors.transparent,
                        //     width: 1,
                        //   ),
                        //   borderRadius: BorderRadius.circular(8),
                        // ),
                        // ),
                      )
                    : Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                        child: OutlinedButton(
                          child: const Text('thay đổi'),
                          onPressed: () {
                            EditCar();
                          },
                        ),
                      )
              ],
            ),
          ),
        ));
  }
}
