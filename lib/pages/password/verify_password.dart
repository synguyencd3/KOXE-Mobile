import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:mobile/services/api_service.dart';

class VerifyPassword extends StatefulWidget {
  const VerifyPassword({super.key});

  @override
  State<VerifyPassword> createState() => _VerifyPasswordState();
}

class _VerifyPasswordState extends State<VerifyPassword> {
  String email = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getEmail();
    });
  }

  Future<void> getEmail() async {
    String emailAPI = ModalRoute.of(context)!.settings.arguments as String;
    setState(() {
      email = emailAPI;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Xác thực tài khoản'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Nhập mã otp được gửi đến email $email',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              OtpTextField(
                numberOfFields: 6,
                keyboardType: TextInputType.text,
                borderColor: Color(0xFF512DA8),
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode)async {
                  String response = await APIService.verifyPassword(email, verificationCode);
                  if (response!='')
                    {
                      Navigator.pushReplacementNamed(context, '/new_password',
                          arguments: {'email': email, 'verificationCode': response});
                    }
                  else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Mã xác thực không đúng')));
                    }

                }, // end onSubmit
              ),
            ],
          ),
        ));
  }
}
