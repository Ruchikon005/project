class Profile {
  final int user_id;
  final String username;
  final String email;
  final String tel;
  final String role;

  Profile({this.tel, this.user_id, this.username, this.email, this.role});

  Profile.fromJson(Map<String, dynamic> json)
      : user_id = json['user_id'],
        username = json['username'],
        email = json['email'],
        tel = json['tel'],
        role = json['role'];

  Map<String, dynamic> toJson() => {
        'user_id': user_id,
        'username': username,
        'email': email,
        'tel': tel,
        'role': role,
      };
}
