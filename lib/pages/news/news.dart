import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/news_service.dart';
import 'package:mobile/pages/news/news_card.dart';

import '../../model/articles_model.dart';
import '../loading.dart';

class NewsBoard extends StatefulWidget {
  const NewsBoard({super.key});

  @override
  State<NewsBoard> createState() => _NewsBoardState();
}

class _NewsBoardState extends State<NewsBoard> {
  List<Articles> article = [];
  bool isCalling = false;
  @override
  void initState() {
    super.initState();
    getNews();
  }

  Future<void> getNews() async {
    var list = await NewsService.getArticles();
    setState(() {
      article = list;
      isCalling =true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        title: Text(
          'News',
          //style: FlutterFlowTheme.of(context).titleLarge,
        ),
      ),
      body: article.isEmpty && !isCalling ? Loading() : ListView.builder(
          itemCount: article.length,
          itemBuilder: (context, index) {
            return NewsCard(
                title: article[index].title,
                description: article[index].summary,
                id: article[index].id,
                imageUrl: article[index].thumbnail);
          }),
    );
  }
}
