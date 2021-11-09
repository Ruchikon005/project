class FoodModel {
  final int product_id;
  final String product_name;
  final String categore;
  final String image_path;
  final String product_detail;
  final int price;
  final int quantity;
  final String createdAt;
  final String updateAt;

  FoodModel({
    this.product_id,
    this.product_name,
    this.categore,
    this.image_path,
    this.product_detail,
    this.price,
    this.quantity,
    this.createdAt,
    this.updateAt,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      product_id: json['product_id'] as int,
      product_name: json['product_name'] as String,
      categore: json['categore'] as String,
      image_path: json['image_path'] as String,
      product_detail: json['product_detail'] as String,
      price: json['price'] as int,
      quantity: json['quantity'] as int,
      createdAt: json['createdAt'] as String,
      updateAt: json['updateAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.product_id;
    data['product_name'] = this.product_name;
    data['categore'] = this.categore;
    data['image_path'] = this.image_path;
    data['product_detail'] = this.product_detail;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['createdAt'] = this.createdAt;
    data['updateAt'] = this.updateAt;
    return data;
  }
}
