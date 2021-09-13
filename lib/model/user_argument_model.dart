class UserArgumentModel {
  final int user_id;
  final String role;
  final String tel;
  final String email;
  final String username;
  final String createdAt;
  final String updatedAt;

  UserArgumentModel(this.user_id, this.role, this.tel, this.username,
      this.createdAt, this.updatedAt, this.email);
}
