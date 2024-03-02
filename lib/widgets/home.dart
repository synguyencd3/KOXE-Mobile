import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                            'Khám phá',
                            style: TextStyle(
                              fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Tin tức và khuyến mãi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 10),
                      Image(image: AssetImage('assets/1.png'),
                      fit: BoxFit.cover,),
                      SizedBox(height: 20),
                      Text('Mới đây, trên trang chủ của hãng VinFast, giá bán của hàng loạt mẫu ô tô điện đã có sự điều chỉnh. Tuy nhiên, thay vì giảm như một số hãng xe khác, VinFast lại tăng giá cho các mẫu ô tô điện của mình.'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                            Navigator.pushNamed(context, '/news');
                            },
                            label: Text('Xem tất cả'),
                            icon: Icon(Icons.arrow_forward),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        
            ),
      );
  }
}
