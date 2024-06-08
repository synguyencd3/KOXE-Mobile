import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:mobile/pages/promotions/create_promotion.dart';
import 'package:mobile/services/promotion_service.dart';

import '../../model/promotion_model.dart';
import '../loading.dart';
import '../news/promotion_card.dart';

class SAlonPromotionBoard extends StatefulWidget {
  const SAlonPromotionBoard({super.key});

  @override
  State<SAlonPromotionBoard> createState() => _SAlonPromotionBoardState();
}

class _SAlonPromotionBoardState extends State<SAlonPromotionBoard> {
  List<Promotion> promotions = [];
  bool isCalling = false;
  int index=1;
  @override
  void initState() {
    super.initState();
    getPromotions();
  }

  Future<void> getPromotions() async {
    var list = await PromotionService.getPromotions();
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
              children: [
                TextButton.icon(onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {return NewPromotion();})));
                }, icon: Icon(Icons.add), label:Text('Thêm khuyến mãi')),
                Column(children: promotions.map((e) => PromotionCard(title: e.title, description: e.description, id: e.id, imageUrl: e.thumbnail)).toList(),)
              ]
            )
        ),
      ),
    );
  }
}