import 'package:mobile/model/process_model.dart';
import 'package:mobile/model/salon_model.dart';

List<ConnectionModel> connectionsFromJson(dynamic str) =>
    List<ConnectionModel>.from((str).map((x) => ConnectionModel.fromJson(x)));

class ConnectionModel {
  String? id;
  String? status;
  String? createAt;
  Salon? salon;
  process? processData;

  ConnectionModel({
    this.id,
    this.status,
    this.createAt,
  });

  ConnectionModel.fromJson(Map<String, dynamic> json)
      : id = json['connection_id'],
        status = json['status'],
        createAt = json['createdAt'] == null ? null : json['createdAt'],
        salon = json['salon'] == null ? null : Salon.fromJson(json['salon']),
        processData = json['process'] != null
            ? new process.fromJson(json['process'])
            : null;

  Map<String, dynamic> toJson() => {
        'connection_id': id,
        'status': status,
        'create_at': createAt,
      };
}
