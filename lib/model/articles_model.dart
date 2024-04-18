List<Articles> articlesFromJson(dynamic str) =>
    List<Articles>.from((str).map((x) => Articles.fromJson(x)));

// class Articles {
//   late final String? title;
//   late final String? description;
//   late final String? url;
//   late final String? imageUrl;
//
//   Articles({this.title, this.description, this.imageUrl, this.url});
//
//   Articles.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     description = json['description'];
//     imageUrl = json['urlToImage'];
//     url = json['url'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['title'] = this.title;
//     data['description'] = this.description;
//     data['url'] = this.url;
//     data['urlToImage'] = this.imageUrl;
//     return data;
//   }
// }

class Articles {
  String? id;
  String? thumbnail;
  String? title;
  String? publish;
  String? summary;

  Articles({this.id, this.thumbnail, this.title, this.publish, this.summary});

  Articles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumbnail = json['thumbnail'];
    title = json['title'];
    publish = json['publish'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['thumbnail'] = this.thumbnail;
    data['title'] = this.title;
    data['publish'] = this.publish;
    data['summary'] = this.summary;
    return data;
  }
}
