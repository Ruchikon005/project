import 'package:khnomapp/model/product_model.dart';

class ProductViewModel {
  List<ProductModel> getProduct() {
    return [
      ProductModel(
        name:
            "อมยิ้ม แบบแท่ง ",
        image:
            "assets/images/candy.jpg",
        price: 10,
        discountPercentage: 70,
        sold: 455,
        mall: true,
      ),
      ProductModel(
        name:
            "คุกกี้ชอกโกแล็ตชิป อร่อยหวานมัน",
        image:
            "assets/images/cookie_1.jpg",
        price: 50,
        discountPercentage: 30,
        sold: 10,
        mall: true,
      ),
      ProductModel(
          name:
              "MYST คอนเฟลกเพื่อสุขภาพ มีส่วนผสมธัญพืช",
          image:
              "assets/images/download.jpg",
          price: 70,
          discountPercentage: 30,
          sold: 140,
          shopRecommended: true),
      ProductModel(
        name:
              "คอนเฟลกเคลือบคาราเมล หวานกุบกรอบ",
        image:
            "assets/images/229.jpg",
        price: 60,
        sold: 87,
        mall: true,
      ),
      
    ];
  }
}