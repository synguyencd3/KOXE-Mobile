import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final Function onPressed;
  final String? title;
  const ButtonCustom({required this.onPressed, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.all(15),
        ),
        onPressed: onPressed != null ? () => onPressed!() : null,
        child: Text(title ?? 'Button'),
      ),
    );
    ;
  }
}

