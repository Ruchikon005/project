class Store {
  final int store_id;
  final String store_name;
  final int uid;
  final String createdAt;
  final String updateAt;

  Store({
    this.store_id,
    this.store_name,
    this.uid,
    this.createdAt,
    this.updateAt,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      store_id: json['store_id'] as int,
      store_name: json['store_name'] as String,
      uid: json['uid'] as int,
      createdAt: json['createdAt'] as String,
      updateAt: json['updateAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_id'] = this.store_id;
    data['store_name'] = this.store_name;
    data['uid'] = this.uid;
    data['createdAt'] = this.createdAt;
    data['updateAt'] = this.updateAt;
    return data;
  }
}

