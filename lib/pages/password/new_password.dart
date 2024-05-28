
import 'package:flutter/material.dart';
import 'package:mobile/services/api_service.dart';

final _formKey = GlobalKey<FormState>();

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  late final TextEditingController _newPassword = TextEditingController();
  late final TextEditingController _confirmNewPassword = TextEditingController();
  Map<String,dynamic> data = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Future<void> getEmailAndCode() async {
    Map<String,dynamic> dataAPI = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    setState(() {
      data = dataAPI;
    });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _newPassword.dispose();
    _confirmNewPassword.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đổi mật khẩu'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 10),
              TextFormField(
                controller: _newPassword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu mới',
                  enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      // color: Color(0xFF6F61EF),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mật khẩu mới';
                  }
                  if (value.length < 6) {
                    return 'Mật khẩu phải có ít nhất 6 ký tự';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _confirmNewPassword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Xác nhận mật khẩu mới',
                  enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      // color: Color(0xFF6F61EF),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng xác nhận mật khẩu mới';
                  }
                  if (value != _newPassword.text) {
                    return 'Mật khẩu xác nhận không khớp';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              FilledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() == true) {
                      Navigator.pushReplacementNamed(context, '/login');
                      bool response = await APIService.renewPassword(_newPassword.text, data['email'], data['verificationCode']);
                      if (response) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Đổi mật khẩu thành công'),
                          backgroundColor: Colors.green,
                        ));
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Đổi mật khẩu thất bại'),
                          backgroundColor: Colors.red,
                        ));
                      }
                    }
                  },
                  child: Text('Đổi mật khẩu')),
            ],
          ),
        ),
      ),
    );
  }
}
