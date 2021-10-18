class FoodModel {
  String product_id;
  String product_name;
  String categore;
  String image_path;
  String data_image;
  String product_detail;
  double price;
  String quantity;
  String createdAt;
  String updateAt;

  FoodModel(
      {this.product_id,
      this.product_name,
      this.categore,
      this.image_path,
      this.data_image,
      this.product_detail,
      this.price,
      this.quantity,
      this.createdAt,
      this.updateAt});

  FoodModel.fromJson(Map<String, dynamic> json) {
    product_id = json['product_id'];
    product_name = json['product_name'];
    categore = json['categore'];
    image_path = json['image_path'];
    data_image = json['data_image'];
    product_detail = json['product_detail'];
    price = json['Price'];
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    updateAt = json['updateAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.product_id;
    data['product_name'] = this.product_name;
    data['categore'] = this.categore;
    data['image_path'] = this.image_path;
    data['data_image'] = this.data_image;
    data['product_detail'] = this.product_detail;
    data['Price'] = this.price;
    data['quantity'] = this.quantity;
    data['createdAt'] = this.createdAt;
    data['updateAt'] = this.updateAt;
    return data;
  }
}