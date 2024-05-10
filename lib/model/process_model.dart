import 'package:mobile/model/salon_model.dart';

import 'document_model.dart';

class process {
  String? id;
  String? name;
  Null? description;
  int? type;
  Salon? salon;
  List<Document>? documents;

  process(
      {this.id,
        this.name,
        this.description,
        this.type,
        this.salon,
        this.documents});

  process.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    salon = json['salon'] != null ? new Salon.fromJson(json['salon']) : null;
    if (json['documents'] != null) {
      documents = <Document>[];
      json['documents'].forEach((v) {
        documents!.add(new Document.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    if (this.salon != null) {
      data['salon'] = this.salon!.toJson();
    }
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}