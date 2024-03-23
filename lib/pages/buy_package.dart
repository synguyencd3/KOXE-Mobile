import 'package:flutter/material.dart';
import 'package:mobile/model/package_model.dart';
import 'package:mobile/pages/Payment.dart';
import 'package:mobile/services/payment_service.dart';
import 'package:mobile/widgets/dropdown.dart';
import 'package:mobile/widgets/button.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyPackage extends StatefulWidget {
  const BuyPackage({super.key});

  @override
  State<BuyPackage> createState() => _BuyPackageState();
}

class _BuyPackageState extends State<BuyPackage> {

  final ValueNotifier<String?> dropDownNotifier = ValueNotifier(null);

  late PackageModel package;
  
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
        initPackage();
    });
    super.initState();
  }

  void initPackage() {
     var data = ModalRoute.of(context)!.settings.arguments as Map;
    setState(() {
      package=data['package'];
    });
  }

  @override
  Widget build(BuildContext context) {
   DateTime now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh toán'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Text('Mã hóa đơn: 1', style: TextStyle(fontSize: 20,)),
              Text('Ngày mua: ${now.day}-${now.month}-${now.year}', style: TextStyle(fontSize: 20),),
              Text(
                'Thông tin gói được mua',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text('${package.name}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                      Text('${package.description}'),
                    ],
                  ),
                ),
              ),
              // Text(
              //   'Thông tin người mua',
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // ),
              // Card(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(5),
              //     side: BorderSide(
              //       color: Colors.grey,
              //       width: 2,
              //     ),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.stretch,
              //       children: <Widget>[
              //         Text('Nguyễn Văn A',
              //             style: TextStyle(
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.blue)),
              //         Text('Email'),
              //       ],
              //     ),
              //   ),
              // ),
              Text(
                'Tổng tiền',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ListTile(
                        leading: Text('${package.name}',style: TextStyle(fontSize: 18),),
                        trailing: Text('${package.price} đ',style: TextStyle(fontSize: 18)),
                      ),
                      ListTile(
                        leading: Text('Giảm giá',style: TextStyle(fontSize: 18)),
                        trailing: Text('0 đ',style: TextStyle(fontSize: 18)),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                      ),
                      ListTile(
                        leading: Text('Tổng cộng',style: TextStyle(fontSize: 18)),
                        trailing: Text('${package.price} đ',style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              DropdownMenuExample(
                width: 300,
                valueNotifier: dropDownNotifier,
              ),
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.bottomRight,
                child: ButtonCustom(
                  onPressed: () async {
                   
                   if (dropDownNotifier.value=="Thanh toán qua VNPay")
                   {
                          String? VNPayurl = await PaymentService.getVNPayURL(package.id);
                          if (VNPayurl != null)
                          {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentWebView( url: VNPayurl,),
                            ),
                          );
                          
                          }
                   }
                   else 
                   {
                    String? ZaloPayURL = await PaymentService.getZaloPayURL();
                    //print(ZaloPayURL);
                          // if (ZaloPayURL!= null)
                          // {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => PaymentWebView( url: ZaloPayURL),
                          //   ),
                          // );
                          // }
                    if (ZaloPayURL!= null) {
                      if (await canLaunchUrl(Uri.parse(ZaloPayURL))) {
                        await launchUrl(Uri.parse(ZaloPayURL),
                        mode: LaunchMode.externalApplication);
                        }
                    }
                   }
                  },
                  title: 'Thanh toán',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
