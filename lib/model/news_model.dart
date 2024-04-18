import 'package:flutter/cupertino.dart';

class News {
  Meta? meta;
  String? sId;
  String? id;
  String? title;
  String? summary;
  List<dynamic>? articleBodyContent;
  String content=" ";
  String? thumbnail;
  int? iV;
  String? publish;

  News(
      {this.meta,
        this.sId,
        this.id,
        this.title,
        this.summary,
        this.articleBodyContent,
        this.thumbnail,
        this.iV,
        this.publish});

  News.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    sId = json['_id'];
    id = json['id'];
    title = json['title'];
    summary = json['summary'];
    if (json['articleBodyContent'] != null) {
      articleBodyContent = <dynamic>[];
      json['articleBodyContent'].forEach((v) {
        try {
         // articleBodyContent!.add(ArticleBodyContent.fromJson(v));
          content += ArticleBodyContent.fromJson(v).toString()+'\n';

        }
        catch (e)
        {
          //articleBodyContent!.add(v);
          content +=v+'\n';
        }
        //articleBodyContent!.add(v);
      });
    }
    thumbnail = json['thumbnail'];
    iV = json['__v'];
    publish = json['publish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    data['_id'] = this.sId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['summary'] = this.summary;
    if (this.articleBodyContent != null) {
      data['articleBodyContent'] =
          this.articleBodyContent!.map((v) => v.toJson()).toList();
    }
    data['thumbnail'] = this.thumbnail;
    data['__v'] = this.iV;
    data['publish'] = this.publish;
    return data;
  }
}

class Meta {
  String? author;
  String? publish;

  Meta({this.author, this.publish});

  Meta.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    publish = json['publish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['publish'] = this.publish;
    return data;
  }
}

class ArticleBodyContent {
  List<String>? imgUrls;
  String? caption;

  ArticleBodyContent({this.imgUrls, this.caption});

  ArticleBodyContent.fromJson(Map<String, dynamic> json) {
    imgUrls = json['imgUrls'].cast<String>();
    caption = json['caption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgUrls'] = this.imgUrls;
    data['caption'] = this.caption;
    return data;
  }

  @override
  String toString() {
    return "![$caption](${imgUrls![0]})\n ***${caption}*** \n";
  }


}