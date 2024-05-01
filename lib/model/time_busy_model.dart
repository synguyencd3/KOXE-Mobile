List<TimeBusyModel> timeBusyFromJson(dynamic str) =>
    List<TimeBusyModel>.from((str).map((x) => TimeBusyModel.fromJson(x)));
class TimeBusyModel {
  final DateTime time;

  TimeBusyModel({
    required this.time,
  });

  factory TimeBusyModel.fromJson(Map<String, dynamic> json) {
    return TimeBusyModel(
      time: DateTime.parse(json['date']).toLocal(),
    );
  }
}