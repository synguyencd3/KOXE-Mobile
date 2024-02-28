import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class NewsBoard extends StatefulWidget {
  const NewsBoard({super.key});

  @override
  State<NewsBoard> createState() => _NewsBoardState();
}

class _NewsBoardState extends State<NewsBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'News',
          style: FlutterFlowTheme.of(context).titleLarge,
        ),
      ),
    );
  }
}
