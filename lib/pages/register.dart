import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mobile/model/register_request_model.dart';
import 'package:mobile/services/api_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late final TextEditingController _name;
  late final TextEditingController _username;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  final _formKey = GlobalKey<FormState>();
  bool isAPIcallProcess = false;

  @override
  void initState() {
    _name = TextEditingController();
    _username = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _username.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void Register() {
    setState(() {
      isAPIcallProcess = true;
    });

    RegisterRequest model = RegisterRequest(
        username: _username.text, password: _password.text, name: _name.text);

    APIService.register(model).then((response) {
      // print(response.message);
      // print(response.status);
      if (response.status == 'success') {
        Navigator.pushNamed(context, '/login');
        showDialog(context: context, builder:
            (BuildContext context) {
          return AlertDialog(
            title: Text('Đăng ký thành công!'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
       // backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
         // backgroundColor: FlutterFlowTheme.of(context).primary,
          title: Align(
            child: Text(
              'ĐĂNG KÝ',
              // style: FlutterFlowTheme.of(context).headlineMedium.override(
              //       fontFamily: 'Outfit',
              //       color: Colors.white,
              //       fontSize: 22,
              //     ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  nameField(name: _name),
                  usernameField(username: _username),
                  passwordField(password: _password),
                  ConfirmPasswordField(
                    confirmPassword: _confirmPassword,
                    password: _password,
                  ),
                  Button(
                      name: 'Đăng ký',
                      callback: () {
                        if (_formKey.currentState!.validate()) {
                          Register();
                        }
                      }),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                    child: Text(
                      'Or',
                    //  style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ),
                  Button(
                    width: 230,
                    name: 'Đăng nhập với Google',
                    callback: () {
                      Navigator.pushNamed(context, '/register');
                    },
                  ),
                  Button(
                    width: 230,
                    name: 'Đăng nhập với Facebook',
                    callback: () {
                      Navigator.pushNamed(context, '/register');
                    },
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Đã có tài khoản?',
                        //  style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        GestureDetector(
                          child: Text(
                            ' Đăng nhập ngay',
                            style: TextStyle(color: Colors.blue[400]),
                          ),
                          onTap: () {
                            Navigator.popAndPushNamed(context, '/login');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class nameField extends StatelessWidget {
  const nameField({
    super.key,
    required TextEditingController name,
  }) : _name = name;

  final TextEditingController _name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      child: TextFormField(
        validator: (email) {
          if (email == "") return 'Please enter your name';
          return null;
        },
        controller: _name,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(7))),
          labelText: 'Họ tên',
         // labelStyle: FlutterFlowTheme.of(context).labelMedium,
        //  hintStyle: FlutterFlowTheme.of(context).labelMedium,
        ),
      ),
    );
  }
}

class usernameField extends StatelessWidget {
  const usernameField({
    super.key,
    required TextEditingController username,
  }) : _username = username;

  final TextEditingController _username;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      child: TextFormField(
        validator: (username) {
          if (username == "") return 'Vui lòng nhập tên tài khoản';
          return null;
        },
        controller: _username,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(7))),
          labelText: 'Tên tài khoản',
       //   labelStyle: FlutterFlowTheme.of(context).labelMedium,
        //  hintStyle: FlutterFlowTheme.of(context).labelMedium,
        ),
      ),
    );
  }
}

class passwordField extends StatelessWidget {
  const passwordField({
    super.key,
    required TextEditingController password,
  }) : _password = password;

  final TextEditingController _password;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      child: TextFormField(
        validator: (value) {
          if (value == "") return "Vui lòng nhập mật khẩu";
          return null;
        },
        obscureText: true,
        controller: _password,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(7))),
          hintText: 'Mật khẩu',
       //   labelStyle: FlutterFlowTheme.of(context).labelMedium,
       //   hintStyle: FlutterFlowTheme.of(context).labelMedium,
        ),
      ),
    );
  }
}

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({
    super.key,
    required TextEditingController confirmPassword,
    required TextEditingController password,
  })  : _password = password,
        _confirmPassword = confirmPassword;

  final TextEditingController _confirmPassword;
  final TextEditingController _password;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
      child: TextFormField(
        validator: (confirmation) {
          print(confirmation);
          print(_password.text);
          return (confirmation == _password.text)
              ? null
              : "Mật khẩu không khớp";
        },
        obscureText: true,
        controller: _confirmPassword,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7))),
          hintText: 'Nhập lại mật khẩu',
      //    labelStyle: FlutterFlowTheme.of(context).labelMedium,
       //   hintStyle: FlutterFlowTheme.of(context).labelMedium,
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String name;
  final VoidCallback callback;
  final double? width;

  const Button({
    super.key,
    this.width,
    required this.name,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
      child: OutlinedButton(
        onPressed: callback,
        child: Text('$name'),
        // options: FFButtonOptions(
        //   height: 40,
        //   width: width,
        //   padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
        //   iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        //   color: FlutterFlowTheme.of(context).primary,
        //   textStyle: FlutterFlowTheme.of(context).titleSmall.override(
        //         fontFamily: 'Readex Pro',
        //         color: Colors.white,
        //       ),
        //   elevation: 3,
        //   borderSide: BorderSide(
        //     color: Colors.transparent,
        //     width: 1,
        //   ),
        //   borderRadius: BorderRadius.circular(8),
        // ),
      ),
    );
  }
}
