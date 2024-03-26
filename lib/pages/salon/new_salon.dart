import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class NewSalon extends StatefulWidget {
  const NewSalon({super.key});

  @override
  State<NewSalon> createState() => _NewSalonState();
}

class _NewSalonState extends State<NewSalon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm salon',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'Outfit',
                  color: Color(0xFF15161E),
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
        child: SingleChildScrollView(
          child: Column(children: [


            TextFormField(
              decoration: InputDecoration(labelText: 'Tên salon',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF6F61EF),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20),

            TextFormField(
              decoration: InputDecoration(labelText: 'Địa chỉ salon',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF6F61EF),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 20),

            TextFormField(
              decoration: InputDecoration(labelText: 'Số điện thoại',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF6F61EF),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 20),

            TextFormField(
              decoration: InputDecoration(labelText: 'Email',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF6F61EF),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            )

          ],),
        ),
      )
    );
  }
}