import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutterflow_ui/flutterflow_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  void Register() async {
    final email = _email.text;
    final password = _password.text;
    var url = Uri.https('dummyjson.com','auth/login');
    var response = await http.post(url, body: {
      'username': '$email',
      'password': '$password'
    });
    print('Response body: ${response.body}');
  }

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
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
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            emailField(email: _email),
            passwordField(password: _password),
            RegisterButton(name: 'Login', callback: Register),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
              child: Text(
                'Or',
                style: FlutterFlowTheme.of(context).bodyMedium,
              ),
            ),
            RegisterButton(name: 'Register', callback: () {print('pressed');},),
        ]),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {

  final String name;
  final VoidCallback callback;

  const RegisterButton({
    super.key,
    required this.name,
    required this.callback,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
      child: FFButtonWidget(
            onPressed: callback,
            text: '$name',
            options: FFButtonOptions(
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

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
          child: FFButtonWidget(
            onPressed: () {
              print('Button pressed ...');
            },
            text: 'Login',
            options: FFButtonOptions(
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
    required TextEditingController email,
  }) : _email = email;

  final TextEditingController _email;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: InputDecoration(
        labelText: 'Enter Email',
        labelStyle: FlutterFlowTheme.of(context).labelMedium,
        hintStyle: FlutterFlowTheme.of(context).labelMedium,
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
    return TextField(
      controller: _password,
      decoration: InputDecoration(
        hintText: 'Enter Password',
        labelStyle: FlutterFlowTheme.of(context).labelMedium,
        hintStyle: FlutterFlowTheme.of(context).labelMedium,
      ),
    );
  }
}