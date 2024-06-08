import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:mobile/pages/promotions/create_promotion.dart';
import 'package:mobile/services/promotion_service.dart';

import '../../model/promotion_model.dart';
import '../loading.dart';
import '../news/PromotionArticle.dart';


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
      promotions=list;
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
                Column(children: promotions.map((e) => PromotionCard(title: e.title, description: e.description, id: e.id, imageUrl: e.thumbnail, fetch: getPromotions ,)).toList(),)
              ]
            )
        ),
      ),
    );
  }
}

class PromotionCard extends StatelessWidget {
  const PromotionCard(
      {super.key,
        required this.title,
        required this.description,
        required this.id,
        required this.fetch,
        this.imageUrl});

  final String? title;
  final String? description;
  final String? id;
  final String? imageUrl;
  final Function fetch;

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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {

                      }, icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        PromotionService.DeletePromotion(id!).then((value) => {
                          if (value==true) fetch()
                        });
                      },
                      icon: Icon(Icons.delete)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
