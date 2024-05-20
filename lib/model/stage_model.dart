
import 'commission_detail_model.dart';

class StageModel {
  final String? stage_id;
  final String? name;
  final double? commissionRate;
  final int? order;
  final List<CommissionDetailModel>? commissionDetails;

  StageModel({
     this.stage_id,
     this.name,
     this.commissionRate,
     this.order,
    this.commissionDetails,
  });

  factory StageModel.fromJson(Map<String, dynamic> json) {
    return StageModel(
      stage_id: json['stage_id'],
      name: json['name'],
      commissionRate: json['commissionRate'],
      order: json['order'],
      commissionDetails: json['commissionDetails']!=null ?commissionDetailFromJson(json['commissionDetails']): null,
    );
  }
}