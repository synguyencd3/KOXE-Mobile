import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/services/api_service.dart';

class Social extends StatefulWidget {
  const Social({super.key});

  @override
  State<Social> createState() => _SocialState();
}

class _SocialState extends State<Social> {
  Map<String, dynamic> userProfile = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
     getProfile();
    });
  }

  void getProfile() {
    var data = ModalRoute.of(context)!.settings.arguments as Map;
    if (data.isNotEmpty)
    {
      setState(() {
        userProfile = data['profile'];
      });
    }
  }

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
            trailing: userProfile['google']==null ?Icon(Icons.arrow_forward): Text('Đã liên kết'),
            onTap: userProfile['google']==null ? () {
              //print('Tap');
              APIService.googleLinkIn().then((value) {
                if (value) Navigator.pop(context);
              });
            }: null,
          ),
          SizedBox(height: 10),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/facebook.png'),
            ),
            title: Text('Facebook'),
            trailing: userProfile['facebook'] ==null ? Icon(Icons.arrow_forward): Text('Đã liên kết'),
            onTap:  userProfile['facebook'] ==null ? () {
              //print('Tap');
              APIService.facebookLinkIn().then((value) {
                if (value) Navigator.pop(context);
              });
            }: null,
          ) ,
        ],
      ),
    );
  }
}
