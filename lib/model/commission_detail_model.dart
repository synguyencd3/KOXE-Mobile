List<CommissionDetailModel> commissionDetailFromJson(dynamic str) =>
    List<CommissionDetailModel>.from((str).map((x) => CommissionDetailModel.fromJson(x)));


class CommissionDetailModel{
  String? commissionDetailId;
  String? name;

  CommissionDetailModel({this.commissionDetailId, this.name});

  factory CommissionDetailModel.fromJson(Map<String, dynamic> json){
    return CommissionDetailModel(
      commissionDetailId: json['id'],
      name: json['name']
    );
  }
}