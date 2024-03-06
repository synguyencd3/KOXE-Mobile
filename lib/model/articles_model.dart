List<Articles> articlesFromJson(dynamic str) =>
    List<Articles>.from((str).map((x) => Articles.fromJson(x)));

class Articles {
  late final String? title;
  late final String? description;
  late final String? url;
  late final String? imageUrl;

  Articles({this.title, this.description, this.imageUrl, this.url});

  Articles.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    imageUrl = json['urlToImage'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlToImage'] = this.imageUrl;
    return data;
  }
}
