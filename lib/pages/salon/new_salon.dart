import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/model/salon_model.dart';
import 'package:mobile/services/salon_service.dart';

class NewSalon extends StatefulWidget {
  const NewSalon({super.key});

  static const String type = 'create';

  @override
  State<NewSalon> createState() => _NewSalonState();
}

class _NewSalonState extends State<NewSalon> {
  List<File>? image;
 List<XFile>? pickedFile;
  final picker = ImagePicker();
  Salon? salon;

  late final TextEditingController _name  = TextEditingController(); 
  late final TextEditingController _address  = TextEditingController();
  late final TextEditingController _phonenumber  = TextEditingController();
  late final TextEditingController _email  = TextEditingController();
  late final TextEditingController _description  = TextEditingController();

  Future<void> pickImage() async {
    pickedFile =  await picker.pickMultiImage();
    if (pickedFile !=null) {
      setState(() {
        image = pickedFile!.map((e) => File(e.path)).toList();
      });
    }
  }

  void NewSalon() {
    Salon salon = Salon(name: _name.text, 
                        address: _address.text, 
                        introductionMarkdown: _description.text,
                        phoneNumber: _phonenumber.text, 
                        email: _email.text,
                        banner: pickedFile?.map((e) => e.path).toList());
    
    SalonsService.NewSalon(salon).then((value) {
      if (value==true)
      {
        Navigator.pop(context);
      }
    });
  }

    void EditSalon() {
    Salon salonForm = Salon(name: _name.text, 
                        address: _address.text, 
                        introductionMarkdown: _description.text,
                        phoneNumber: _phonenumber.text, 
                        email: _email.text,
                        banner: pickedFile?.map((e) => e.path).toList());
    
    SalonsService.EditSalon(salonForm, salon!.salonId!).then((value) {
      if (value==true)
        {
          Navigator.popUntil(context, ModalRoute.withName('/salons'));
        }
    });
  }


  void initSalon() {
  var data = ModalRoute.of(context)!.settings.arguments as Map;
  setState(() {
    salon = data['salon'];
  });
  _name.text = salon?.name ?? "";
  _address.text = salon?.address ?? "";
  _description.text = salon?.introductionMarkdown ?? "";
  _phonenumber.text = salon?.phoneNumber ?? "";
  _email.text = salon?.email ?? "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      initSalon();
    }); 
    
  }



  //TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm salon',
                //   style: FlutterFlowTheme.of(context).titleLarge.override(
                //   fontFamily: 'Outfit',
                //   color: Color(0xFF15161E),
                //   fontSize: 22,
                //   fontWeight: FontWeight.w500,
                // ),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
        child: SingleChildScrollView(
          child: Column(children: [

            TextFormField(
              controller: _name,
              decoration: InputDecoration(labelText: 'Tên salon',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              ),
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
              controller: _address,
              decoration: InputDecoration(labelText: 'Địa chỉ salon',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              ),
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
              controller: _phonenumber,
              decoration: InputDecoration(labelText: 'Số điện thoại',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              ),
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
              controller: _email,
              decoration: InputDecoration(labelText: 'Email',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              ),
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
            
            contentPadding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 12),
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

        SizedBox( height: 20,),

        GestureDetector(
          onTap: () => pickImage(),
          child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
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
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.add_a_photo_rounded,
                    size: 32,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
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
          )
          ),
        ),

        SizedBox(height: 20),

        Container(
          width: double.infinity,
          child: pickedFile==null
          ? const Text('Vui lòng chọn ảnh')
          : Text('${pickedFile!.length} ảnh đã chọn')
        ), 

        SizedBox(height: 20),
        
        salon == null?
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
          child: OutlinedButton(child: Text('tạo salon'), onPressed: () {
            NewSalon();
          } ,),
          
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
        ) :

              Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
          child: OutlinedButton(child: Text('thay đổi'), onPressed: () {
            EditSalon();
          } ,),
        )


          ],),
        ),
      )
    );
  }
}