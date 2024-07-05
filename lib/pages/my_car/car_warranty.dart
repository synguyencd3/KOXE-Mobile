import 'package:flutter/material.dart';
import 'package:mobile/model/warranty_model.dart';
import 'package:mobile/services/cars_service.dart';

class CarWarranty extends StatefulWidget {
  const CarWarranty({super.key});

  @override
  State<CarWarranty> createState() => _CarWarrantyState();
}

class _CarWarrantyState extends State<CarWarranty> {
  Warranty warranty = Warranty();

  Future<void> getWarranty() async {
    var arg = ModalRoute.of(context)!.settings.arguments as String;
    var data = await CarsService.getDetail(arg);
    warranty = data!.warranty!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bảo hành'),
      ),
      body: FutureBuilder(
          future: getWarranty(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return warranty.name != null
                ? Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${warranty.name}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                              '${warranty.limitKilometer} Km đầu tiên trong vòng ${warranty.months} tháng'),
                        ],
                      ),
                    ),
                  )
                : Center(child: Text('Không có bảo hành'));
          }),
    );
  }
}
