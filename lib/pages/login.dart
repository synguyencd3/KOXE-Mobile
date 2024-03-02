import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mobile/model/login_request_model.dart';
import 'package:mobile/services/api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _username;
  late final TextEditingController _password;
  bool isAPIcallProcess = false;

  void Login() {
    // final email = _email.text;
    // final password = _password.text;
    // var url = Uri.https('dummyjson.com','auth/login');
    // var response = await http.post(url, body: {
    //   'username': '$email',
    //   'password': '$password'
    // });
    // var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    // var token = decodedResponse['token'];
    // if (token == null)
    // {
    //   print('wrong password or username');
    // } else
    // {
    //   print('login success');
    // }

    setState(() {
      isAPIcallProcess = true;
    });

    LoginRequest model =
        LoginRequest(email: _username.text, password: _password.text);

    APIService.login(model).then((response) => {
          if (response)
            {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/mhome', (route) => false)
            }
          else
            {print("login failed")}
        });
  }

  @override
  void initState() {
    _username = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        title: Align(
          child: Text(
            'LOGIN',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22,
                ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            height: 50,
          ),

          //Input Field
          emailField(username: _username),
          passwordField(password: _password),

          //Forgot Password Text
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text('Forgot Password?')],
            ),
          ),

          //Button
          Button(name: 'Login', callback: Login),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
            child: Text(
              'Or',
              style: FlutterFlowTheme.of(context).bodyMedium,
            ),
          ),

          Button(
            width: 230,
            name: 'Sign in with Google',
            callback: () {
              Navigator.pushNamed(context, '/register');
            },
          ),

          Button(
            width: 230,
            name: 'Sign in with Facebook',
            callback: () {
              Navigator.pushNamed(context, '/register');
            },
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Dont't have an account?"),
                const SizedBox(
                  width: 2,
                ),
                GestureDetector(
                  child: Text(
                    "Sign up",
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
      child: FFButtonWidget(
        showLoadingIndicator: false,
        onPressed: callback,
        text: '$name',
        options: FFButtonOptions(
          width: width,
          height: 40,
          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
          iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          color: FlutterFlowTheme.of(context).primary,
          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                fontFamily: 'Readex Pro',
                color: Colors.white,
              ),
          elevation: 3,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
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
          labelText: 'Username',
          labelStyle: FlutterFlowTheme.of(context).labelMedium,
          hintStyle: FlutterFlowTheme.of(context).labelMedium,
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
          hintText: 'Password',
          labelStyle: FlutterFlowTheme.of(context).labelMedium,
          hintStyle: FlutterFlowTheme.of(context).labelMedium,
        ),
      ),
    );
  }
}
