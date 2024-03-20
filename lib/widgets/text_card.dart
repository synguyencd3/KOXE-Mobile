import 'package:flutter/material.dart';

class text_card extends StatelessWidget {
  final String title;
  final Function onTap;
  final IconData icon;
  final String trailingText;

  const text_card(
      {required this.title,
      required this.onTap,
      this.icon = Icons.arrow_forward_ios,
      this.trailingText = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(trailingText, style: TextStyle(color: Colors.grey[800], fontSize: 16)),
              Icon(icon),
            ],
          ),
          title: Text(title),
          onTap: onTap != null ? () => onTap!() : null, // Đã sửa ở đây
        ),
        Divider(
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }
}
