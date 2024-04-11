import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Social extends StatefulWidget {
  const Social({super.key});

  @override
  State<Social> createState() => _SocialState();
}

class _SocialState extends State<Social> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kết nối mạng xã hội'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/google.png'),
            ),
            title: Text('Google'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              print('Tap');
            },
          ),
          SizedBox(height: 10),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/facebook.png'),
            ),
            title: Text('Facebook'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              print('Tap');
            },
          ),
        ],
      ),
    );
  }
}
