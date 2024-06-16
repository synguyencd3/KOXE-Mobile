import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mobile/model/login_request_model.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/services/shared_service.dart';
import 'package:mobile/socket/socket_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _username;
  late final TextEditingController _password;
  late final TextEditingController _email;
  bool isAPIcallProcess = false;

  void Login() {
    setState(() {
      isAPIcallProcess = true;
    });
    Future<void> initSocket() async {
      final Map<String, dynamic> userProfile =
          await APIService.getUserProfile();
      String salonId = await SalonsService.isSalon();
      await SocketManager().initSocket(userProfile['user_id'], salonId, (data) {
        print(data);
      });
    }

    LoginRequest model =
        LoginRequest(username: _username.text, password: _password.text);

    APIService.login(model).then((response) => {
          if (response)
            {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/mhome', (route) => false),
              initSocket()
            }
          else
            {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Đăng nhập không thành công'),
                      content: Text('Kiểm tra lại thông tin đăng nhập'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'))
                      ],
                    );
                  })
            }
        });
  }

  void googleSignIn() {
    APIService.googleSignIn().then((success) => {
          if (success)
            {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/mhome', (route) => false)
            }
          else
            {print("Đăng nhập thất bại")}
        });
  }

  void IsLoggedIn() async {
    if (await SharedService.isLoggedIn()) {
      Navigator.pushNamedAndRemoveUntil(context, '/mhome', (route) => false);
    }
  }

  void facebookSignIn() {
    APIService.facebookSignIn().then((success) => {
          if (success)
            {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/mhome', (route) => false)
            }
          else
            {print("Đăng nhập thất bại")}
        });
  }

  @override
  void initState() {
    _username = TextEditingController();
    _password = TextEditingController();
    _email = TextEditingController();
    super.initState();
    IsLoggedIn();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // backgroundColor: FlutterFlowTheme.of(context).primary,
        title: Align(
          child: Text(
            'Đăng nhập',
            // style: FlutterFlowTheme.of(context).headlineMedium.override(
            //       fontFamily: 'Outfit',
            //       color: Colors.white,
            //       fontSize: 22,
            //     ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(40),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: 50,
            ),

            //Input Field
            emailField(username: _username),
            passwordField(password: _password),

            //Forgot Password Text
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Nhập email khôi phục'),
                        content: TextField(
                          controller: _email,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(7))),
                            hintText: 'Email',
                            // labelStyle: FlutterFlowTheme.of(context).labelMedium,
                            //hintStyle: FlutterFlowTheme.of(context).labelMedium,
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Hủy')),
                          TextButton(
                              onPressed: () async {
                                bool response = await APIService.forgotPassword(
                                    _email.text);
                                if (response) {
                                  Navigator.pushNamed(
                                      context, '/verify_password',
                                      arguments: _email.text);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Email không tồn tại')));
                                }
                              },
                              child: Text('Gửi mã xác nhận')),
                        ],
                      );
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Text('Quên mật khẩu?')],
                ),
              ),
            ),

            //Button
            Button(name: 'Đăng nhập', callback: Login),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
              child: Text(
                'Hoặc',
                // style: FlutterFlowTheme.of(context).bodyMedium,
              ),
            ),

            Button(
              width: 230,
              name: 'Đăng nhập với Google',
              callback: () {
                //Navigator.pushNamed(context, '/register');
                googleSignIn();
              },
            ),

            Button(
              width: 230,
              name: 'Đăng nhập với Facebook',
              callback: () {
                //Navigator.pushNamed(context, '/fblogin');
                facebookSignIn();
              },
            ),

            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Chưa có tài khoản ? "),
                  const SizedBox(
                    width: 2,
                  ),
                  GestureDetector(
                    child: Text(
                      "Đăng ký ngay",
                      style: TextStyle(color: Colors.blue[400]),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                  ),
                ],
              ),
            ),
          ]),
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
        //showLoadingIndicator: false,
        onPressed: callback,
        child: Text('$name'),
        //text: '$name',
        // options: FFButtonOptions(
        //   width: width,
        //   height: 40,
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

class emailField extends StatelessWidget {
  const emailField({
    super.key,
    required TextEditingController username,
  }) : _username = username;

  final TextEditingController _username;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
      child: TextField(
        controller: _username,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(7))),
          labelText: 'Tài khoản',
          // labelStyle: FlutterFlowTheme.of(context).labelMedium,
          // hintStyle: FlutterFlowTheme.of(context).labelMedium,
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
      padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
      child: TextField(
        obscureText: true,
        controller: _password,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(7))),
          hintText: 'Mật khẩu',
          // labelStyle: FlutterFlowTheme.of(context).labelMedium,
//hintStyle: FlutterFlowTheme.of(context).labelMedium,
        ),
      ),
    );
  }
}
