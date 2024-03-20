import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final Function onPressed;
  final String? title;
  const ButtonCustom({required this.onPressed, this.title});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.all(20),
      ),
      onPressed: onPressed != null ? () => onPressed!() : null,
      child: Text(title ?? 'Button'),
    );
    ;
  }
}

