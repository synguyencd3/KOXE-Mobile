import 'package:mobile/model/salon_model.dart';
import 'package:mobile/model/stage_model.dart';

import 'document_model.dart';
List<process> processFromJson(dynamic str) =>
    List<process>.from((str).map((x) => process.fromJson(x)));
class process {
  String? id;
  String? name;
  String? carId;
  String? description;
  int? type;
  Salon? salon;
  List<Document>? documents;
  List<StageModel>? stages;

  process(
      {this.id,
        this.name,
        this.description,
        this.type,
        this.carId,
        this.salon,
        this.documents});

  process.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carId = json['carId'];
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
    if (json['stages'] != null) {
      stages = <StageModel>[];
      json['stages'].forEach((v) {
        stages!.add(new StageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null ) data['id'] = this.id;
    if (carId != null) data['carId'] = this.carId;
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