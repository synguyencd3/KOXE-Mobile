List<authority> authoritiesFromJson(dynamic str) =>
    List<authority>.from((str).map((x) => authority.fromJson(x)));


class authority {
  String? id;
  String? name;
  List<String>? permissions;

  authority({this.id, this.name, this.permissions});

  authority.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    json["permissions"] == null ? permissions = <String>[] : permissions = permission(json["permissions"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['permissions'] = this.permissions;
    return data;
  }
}

List<String> permission(Map<String, dynamic> permissionMap){
  if (permissionMap == null) return <String>[];
  List<String> output = [];
  for (MapEntry<String, dynamic> entries in permissionMap.entries)
  {
    //  var Category= entries.key; //chưa dử dụng tới
    Map<String, dynamic> CategoryPermission = entries.value;
    CategoryPermission.forEach((key, value) {output.add(key);});
  }
  return output;
}
