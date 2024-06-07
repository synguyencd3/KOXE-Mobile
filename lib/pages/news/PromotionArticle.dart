import 'dart:async';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mobile/model/news_model.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/promotion_article_model.dart';
import 'package:mobile/pages/salon/salon_list.dart';
import 'package:mobile/services/news_service.dart';
import 'package:mobile/services/salon_service.dart';

import '../../model/salon_model.dart';


class PromotionArticle extends StatefulWidget {
  final String id;
  final String title;
  final String thumbnail;
  const PromotionArticle({
    super.key,
    required this.id,
    required this.thumbnail,
    required this.title
  });

  @override
  State<PromotionArticle> createState() => _PromotionArticleState();
}

class _PromotionArticleState extends State<PromotionArticle> {
  late PromotionArticleModel _model = PromotionArticleModel();
  Salon? _salon;

  @override
  void initState() {
    super.initState();
    initArticle();
  }

  void initArticle() async {
    var data = await NewsService.getPromotion(widget.id);
   setState(() {
     _model = data!;
   });
    getSalon();
  }

  void getSalon() async {
    var data = await SalonsService.getSalon(_model.salon!.salonId!);
    print(data);
    setState(() {
      _salon = data!;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      //backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [

                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                  child: Text(
                    widget.title,
                   style: TextStyle(
                     fontSize: 24,
                     fontWeight: FontWeight.bold
                   ),
                  ),
                ),
                Image.network(_model.banner?[0] ??
                    "https://ralfvanveen.com/wp-content/uploads/2021/06/Placeholder-_-Glossary.svg"),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                  child: MarkdownBody(
                    data: _model.contentMarkdown == null ? "":
                    _model.contentMarkdown!
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Khuyến mãi áp dụng tại salon",
                        style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                _salon != null ?SalonCard(salon: _salon!) : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
