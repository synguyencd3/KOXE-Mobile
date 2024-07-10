import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/model/post_model.dart';
import 'package:mobile/utils/utils.dart';


class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       Navigator.pushNamed(context, '/post_detail', arguments: post.postId);
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
                backgroundImage: NetworkImage(post.user?.avatar ?? ''),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.title ?? 'Không có tiêu đề'),
                  Text('Ngày đăng: ' + formatDate(post.createAt!)),
                  Text('Người đăng: ' + post.user!.fullname),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
