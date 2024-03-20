import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/widgets/news_card.dart';

import '../model/articles_model.dart';

class NewsBoard extends StatefulWidget {
  const NewsBoard({super.key});

  @override
  State<NewsBoard> createState() => _NewsBoardState();
}

class _NewsBoardState extends State<NewsBoard> {
  List<Articles> article = [];
  @override
  void initState() {
    super.initState();
    getNews();
  }

  Future<void> getNews() async {
    var list = await APIService.getArticles();
    setState(() {
      article = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        title: Text(
          'News',
          style: FlutterFlowTheme.of(context).titleLarge,
        ),
      ),
      body: ListView.builder(
          itemCount: article.length,
          itemBuilder: (context, index) {
            return NewsCard(
                title: article[index].title,
                description: article[index].description,
                url: article[index].url,
                imageUrl: article[index].imageUrl);
          }),
    );
  }
}
