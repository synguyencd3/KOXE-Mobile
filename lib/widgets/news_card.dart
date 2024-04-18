import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile/pages/news/Article.dart';

class NewsCard extends StatelessWidget {
  const NewsCard(
      {super.key,
      required this.title,
      required this.description,
      required this.id,
      required this.imageUrl});

  final String? title;
  final String? description;
  final String? id;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleWidget(id: id ?? "", thumbnail: imageUrl?? "", title: title ?? "",)));
        },
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(child: Image.network(imageUrl!),
                borderRadius: BorderRadius.circular(8),),
              ),
              Align(
                alignment: AlignmentDirectional(-1, 0),
                child: Column(
                  children: [Text(title!, style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                    SizedBox(height: 3),
                   Padding(
                     padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                     child: Text(description!)
                )],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
