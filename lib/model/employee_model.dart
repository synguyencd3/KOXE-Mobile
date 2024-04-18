List<Employee> employeesFromJson(dynamic str) =>
    List<Employee>.from((str).map((x) => Employee.fromJson(x)));

class Employee {
  String? userId;
  String? username;
  String? password;
  String? fullname;
  String? gender;
  String? phone;
  String? email;
  String? address;
  String? dateOfBirth;
  String? avatar;
  String? role;
  String? facebook;
  String? google;
  int? aso;
  List<String>? permissions;

  Employee(
      {this.userId,
        this.username,
        this.password,
        this.fullname,
        this.gender,
        this.phone,
        this.email,
        this.address,
        this.dateOfBirth,
        this.avatar,
        this.role,
        this.facebook,
        this.google,
        this.aso,
        this.permissions});

  Employee.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    password = json['password'];
    fullname = json['fullname'];
    gender = json['gender'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    dateOfBirth = json['date_of_birth'];
    avatar = json['avatar'];
    role = json['role'];
    facebook = json['facebook'];
    google = json['google'];
    aso = json['aso'];
    print(json["permissions"]);
    json["permissions"] == null ? permissions = <String>[] : permissions = permission(json["permissions"]);
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['password'] = this.password;
    data['fullname'] = this.fullname;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['date_of_birth'] = this.dateOfBirth;
    data['avatar'] = this.avatar;
    data['role'] = this.role;
    data['facebook'] = this.facebook;
    data['google'] = this.google;
    data['aso'] = this.aso;
    data['permissions'] = this.permissions;
    return data;
  }
}


