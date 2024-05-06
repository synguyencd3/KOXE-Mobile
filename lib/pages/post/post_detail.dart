import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({super.key});

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Post Detail'),
        ),
        body: Center(
          child: Text('Post Detail'),
        ),
        floatingActionButton: Row(
          children: [
            Expanded(
              child: FloatingActionButton(
                onPressed: () {},
                child: Text('Kết nối'),
              ),
            ),
            Expanded(
              child: FloatingActionButton(
                onPressed: () {},
                child: Text('Nhắn tin'),
              ),
            ),
          ],
        ));
  }
}
