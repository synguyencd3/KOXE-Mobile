List<ConnectionModel> connectionsFromJson(dynamic str) =>
    List<ConnectionModel>.from((str).map((x) => ConnectionModel.fromJson(x)));

class ConnectionModel {
  String? id;
  String? status;
  DateTime? createAt;

  ConnectionModel({
    this.id,
    this.status,
    this.createAt,
  });

  ConnectionModel.fromJson(Map<String, dynamic> json)
      : id = json['connection_id'],
        status = json['status'],
        createAt = DateTime.parse(json['create_at']);

  Map<String, dynamic> toJson() => {
        'connection_id': id,
        'status': status,
        'create_at': createAt,
      };
}
