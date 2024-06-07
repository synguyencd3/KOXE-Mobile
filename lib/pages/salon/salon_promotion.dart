import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/promotion_model.dart';
import 'package:mobile/pages/news/promotion_card.dart';

import '../loading.dart';

class SalonPromotions extends StatefulWidget {
  const SalonPromotions({Key? key, required this.salonPromotions}) : super(key: key);
  final List<Promotion> salonPromotions;
  @override
  State<SalonPromotions> createState() => _SalonCarState();
}

class _SalonCarState extends State<SalonPromotions> {
  List<Promotion> promotions = [];
  bool isCalling = false;
  @override
  void initState() {
    super.initState();
    getCars();
  }
  Future<void> getCars() async {
    setState(() {
      promotions = widget.salonPromotions;
      isCalling =true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Khuyến mãi',
            //   style: FlutterFlowTheme.of(context).titleLarge,
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child:promotions.isEmpty && !isCalling ? Loading(): ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: promotions.length,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          PromotionCard(title: promotions[index].title,
                              description: promotions[index].description,
                              id: promotions[index].id,
                          imageUrl: promotions[index].thumbnail)
                        ],
                      );
                    }))
          ],
        ));
  }
}