import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/model/post_model.dart';

class PostCard extends StatefulWidget {
  PostModel post;

  PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       Navigator.pushNamed(context, '/post_detail', arguments: widget.post.postId);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[100],
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 2),
            top: BorderSide(color: Colors.grey, width: 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.post.user?.avatar ?? ''),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.post.title ?? ''),
                  Text(widget.post.createAt.toString()),
                  Text('Người đăng: ' + widget.post.user!.fullname ?? ''),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
