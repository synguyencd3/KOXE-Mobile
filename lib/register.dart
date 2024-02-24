import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
       appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          title: Align(
            child: Text(
              'REGISTER',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontSize: 22,
                  ),
            ),
          ),   
       ), 
       body: Padding(
         padding: EdgeInsets.all(15),
         child: Form(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
                emailField(email: _email),
                passwordField(password: _password),
                confirmPasswordField(password: _confirmPassword),
                Button(name: 'register', callback: () {print('registered');})
            ],),
          ),
       )
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,8,8,0),
      child: TextField(
        controller: _email,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(7))),
          labelText: 'Enter Email',
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
      padding: const EdgeInsets.fromLTRB(0,8,8,0),
      child: TextField(
        obscureText: true,
        controller: _password,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(7))),
          hintText: 'Enter Password',
          labelStyle: FlutterFlowTheme.of(context).labelMedium,
          hintStyle: FlutterFlowTheme.of(context).labelMedium,
        ),
      ),
    );
  }
}

class confirmPasswordField extends StatelessWidget {
  const confirmPasswordField({
    super.key,
    required TextEditingController password,
  }) : _password = password;

  final TextEditingController _password;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,8,8,0),
      child: TextField(
        obscureText: true,
        controller: _password,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(7))),
          hintText: 'Confirm Password',
          labelStyle: FlutterFlowTheme.of(context).labelMedium,
          hintStyle: FlutterFlowTheme.of(context).labelMedium,
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {

  final String name;
  final VoidCallback callback;

  const Button({
    super.key,
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

