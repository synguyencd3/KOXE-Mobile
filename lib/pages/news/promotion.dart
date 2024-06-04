import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:mobile/pages/news/promotion_card.dart';

import '../../model/promotion_model.dart';
import '../../services/news_service.dart';
import '../loading.dart';
import 'news_card.dart';

class PromotionBoard extends StatefulWidget {
  const PromotionBoard({super.key});

  @override
  State<PromotionBoard> createState() => _PromotionBoardState();
}

class _PromotionBoardState extends State<PromotionBoard> {
  List<Promotion> promotions = [];
  bool isCalling = false;
  int index=1;
  @override
  void initState() {
    super.initState();
    getPromotions();
  }

  Future<void> getPromotions() async {
    var list = await NewsService.getPromotions(index, 5);
    setState(() {
      if (list.length>0) index++;
      promotions.addAll(list);
      isCalling =true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Khuyến mãi',
        ),
      ),
      body: promotions.isEmpty && !isCalling ? Loading() : LazyLoadScrollView(
        onEndOfPage: () { getPromotions(); },
        child: SingleChildScrollView(
          child:
                Column(
                  children: promotions.map((e) => PromotionCard(title: e.title, description: e.description, id: e.id, imageUrl: e.thumbnail)).toList(),
                )
          ),
        ),
      );
  }
}
