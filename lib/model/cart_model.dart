class Cart {
  final int cart_id;
  final int item_id;
  final int uid;
  final String createdAt;
  final String updateAt;

  Cart({
    this.cart_id,
    this.item_id,
    this.uid,
    this.createdAt,
    this.updateAt,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      cart_id: json['cart_id'] as int,
      item_id: json['item_id'] as int,
      uid: json['uid'] as int,
      createdAt: json['createdAt'] as String,
      updateAt: json['updateAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cart_id;
    data['item_id'] = this.item_id;
    data['uid'] = this.uid;
    data['createdAt'] = this.createdAt;
    data['updateAt'] = this.updateAt;
    return data;
  }
}

