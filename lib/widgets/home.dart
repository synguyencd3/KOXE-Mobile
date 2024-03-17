import 'package:flutter/cupertino.dart';
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
          NewsPadding(),
          SalonPadding(),
          SizedBox(height: 10),
          ServiceCard(),
        ],
      ),
    );
  }
}

class NewsPadding extends StatelessWidget {
  const NewsPadding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              Image(
                image: AssetImage('assets/1.png'),
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                  'Mới đây, trên trang chủ của hãng VinFast, giá bán của hàng loạt mẫu ô tô điện đã có sự điều chỉnh. Tuy nhiên, thay vì giảm như một số hãng xe khác, VinFast lại tăng giá cho các mẫu ô tô điện của mình.'),
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
    );
  }
}

class SalonPadding extends StatelessWidget {
  const SalonPadding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              Text('Các salon',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 10),
              Image(
                image: AssetImage('assets/salon.jpg'),
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                  'Tưng bừng khai trương Mercedes Bình Tân'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/salons');
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
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Text(
                'Các gói dịch vụ',
                style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.topLeft,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    title: Text(
                      'Gói CRM01',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('400.000đ/năm'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/buy_package');
                      },
                      child: Text('Mua ngay'),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Tích hợp facebook',
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Icon(
                      Icons.circle,
                      size: 14,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Mô tả tiếp theo',
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Icon(
                      Icons.circle,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pushNamed(context, '/packages');
              },
              child: Text('Xem tất cả'),
            ),
          ],
        ),
      ),
    );
  }
}
