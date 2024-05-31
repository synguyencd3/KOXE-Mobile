
class UserTransactionModel {
final String user_id;
final String name;

UserTransactionModel({
  required this.user_id,
  required this.name,
});

factory UserTransactionModel.fromJson(Map<String, dynamic> json) {
  return UserTransactionModel(
    user_id: json['user_id'],
    name:  json['name']!=null ?json['name']:'',
  );
}
}