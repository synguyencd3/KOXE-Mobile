import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/car_model.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutterflow_ui/flutterflow_ui.dart';

class CarCard extends StatefulWidget {
  final Car car;

  CarCard({required this.car});

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
                child: Image.network(
                  widget.car.image![0],
                  height: 230,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Tên xe: ${widget.car.name}',
                // style: FlutterFlowTheme.of(context).bodyLarge.override(
                //       fontFamily: 'Plus Jakarta Sans',
                //       color: Color(0xFF15161E),
                //       fontSize: 16,
                //       fontWeight: FontWeight.w600,
                //     ),
              ),
              SizedBox(height: 10),
              Text(
                'Mô tả: ${widget.car.description}',
                // style: FlutterFlowTheme.of(context).labelMedium.override(
                //       fontFamily: 'Outfit',
                //       color: Color(0xFF606A85),
                //       fontSize: 14,
                //       fontWeight: FontWeight.w500,
                //     ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Giá: ${widget.car.price?.toInt()}',
                    // style: FlutterFlowTheme.of(context).labelMedium.override(
                    //       fontFamily: 'Outfit',
                    //       color: Color(0xFF606A85),
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                  ),
                  IconButton(onPressed: () {
                    Navigator.pushNamed(context, '/car_detail', arguments: {
                      'car': widget.car
                    });
                  }, icon: Icon(Icons.arrow_forward))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
