List<UserSearchModel> userSearchFromJson(dynamic str) =>
    List<UserSearchModel>.from((str).map((x) => UserSearchModel.fromJson(x)));
class UserSearchModel {
  final String? user_id;
  final String name;
  final String? salon_id;

  UserSearchModel({
    this.user_id,
    required this.name,
    this.salon_id,
  });

  factory UserSearchModel.fromJson(Map<String, dynamic> json) {
    return UserSearchModel(
      user_id: json.containsKey('user_id') ? json['user_id']:'',
      name:  json['name']!=null ?json['name']:'',
      salon_id: json.containsKey('user_id') ? json['salon_id']:'',
    );
  }
}