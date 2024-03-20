import 'package:flutter/material.dart';
import 'package:mobile/widgets/text_card.dart';


class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cài đặt'),
      ),
      body: Center(
        child: Column(
          children: [
           text_card(title: 'Cài đặt chat', onTap:(){} ),
            text_card(title: 'Cài đặt thông báo', onTap:(){} ),
            text_card(title: 'Ngôn ngữ', onTap:(){} ),

          ],
        ),
      ),
    );
  }
}
