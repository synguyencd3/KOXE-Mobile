import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NewsCard extends StatelessWidget {
  const NewsCard(
      {super.key,
      required this.title,
      required this.description,
      required this.url,
      required this.imageUrl});

  final String? title;
  final String? description;
  final String? url;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        ClipRRect(
          child: Image.network(imageUrl!)
        ),
        Align(
          alignment: AlignmentDirectional(-1,0),
          child: Column(children: [
            Text(title!),
            Text(description!)
          ],),
        )
      ],),
    );
  }
}
