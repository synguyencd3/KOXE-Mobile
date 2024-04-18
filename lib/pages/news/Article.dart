import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mobile/model/news_model.dart';
import 'package:flutter/material.dart';
import 'package:mobile/services/news_service.dart';


class ArticleWidget extends StatefulWidget {
  final String id;
  final String title;
  final String thumbnail;
  const ArticleWidget({super.key, required this.id, required this.thumbnail, required this.title});

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  late News _model = News();

  @override
  void initState() {
    super.initState();
    initArticle();
  }

  void initArticle() async {
    var data = await NewsService.getNews(widget.id);
    print(data?.content);
   setState(() {
     _model = data!;
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                  child: MarkdownBody(
                    data: _model.content == null ? "": _model.content
                    // style: FlutterFlowTheme.of(context).bodyMedium.override(
                    //   fontFamily: 'Readex Pro',
                    //   color: FlutterFlowTheme.of(context).primaryText,
                    //   letterSpacing: 0,
                    // ),
                  ),
                ),

                // Padding(
                //   padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                //   child: Text(
                //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
                //     // style: FlutterFlowTheme.of(context).bodyMedium.override(
                //     //   fontFamily: 'Readex Pro',
                //     //   color: FlutterFlowTheme.of(context).primaryText,
                //     //   letterSpacing: 0,
                //     // ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
