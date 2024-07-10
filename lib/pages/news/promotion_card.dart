import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile/pages/news/Article.dart';
import 'package:mobile/pages/news/PromotionArticle.dart';

class PromotionCard extends StatelessWidget {
  const PromotionCard(
      {super.key,
      required this.title,
      required this.description,
      required this.id,
      this.imageUrl});

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
          Navigator.push(context, MaterialPageRoute(builder: (context) => PromotionArticle(id: id ?? "", thumbnail: imageUrl?? "", title: title ?? "",)));
        },
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              imageUrl != null ?  Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(child: Image.network(imageUrl!),
                borderRadius: BorderRadius.circular(8),),
              ): Container(height: 10,),
              Align(
                alignment: AlignmentDirectional(-1, 0),
                child: Column(
                  children: [Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                    child: Text(title!, style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
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
