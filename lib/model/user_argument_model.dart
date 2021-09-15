class UserArgumentModel {
  String user_id;
  String role;
  String tel;
  String email;
  String username;
  String createdAt;
  String updatedAt;

  UserArgumentModel(
      {this.user_id,
      this.role,
      this.tel,
      this.username,
      this.createdAt,
      this.updatedAt,
      this.email});

  UserArgumentModel.formJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    role = json['role'];
    tel = json['tel'];
    email = json['email'];
    username = json['username'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.user_id;
    data['role'] = this.role;
    data['tel'] = this.tel;
    data['email'] = this.email;
    data['username'] = this.username;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
