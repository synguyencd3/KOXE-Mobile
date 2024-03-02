List<NewsResponse> newsFromJson(dynamic str) =>
    List<NewsResponse>.from((str).map((x) => NewsResponse.fromJson(x)));

class NewsResponse {
  late final String? title;
  late final String? description;
  late final String? url;
  late final String? imageUrl;

  NewsResponse({this.title, this.description, this.imageUrl, this.url});

  NewsResponse.fromJson(Map<String, dynamic> json) {
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
