import 'package:khnomapp/model/product_model.dart';

class MyProductViewModel {
  static List<ProductModel> getMyProduct(String store) {
    print('${store} test..........');
    return [
      ProductModel(
        name: "อมยิ้ม แบบแท่ง ",
        image: "assets/images/candy.jpg",
        price: 10,
        sold: 455,
      ),
      ProductModel(
        name: "คุกกี้ชอกโกแล็ตชิป อร่อยหวานมัน",
        image: "assets/images/cookie_1.jpg",
        price: 50,
        sold: 10,
      ),
      ProductModel(
        name: "MYST คอนเฟลกเพื่อสุขภาพ มีส่วนผสมธัญพืช",
        image: "assets/images/download.jpg",
        price: 70,
        sold: 140,
      ),
      ProductModel(
        name: "คอนเฟลกเคลือบคาราเมล หวานกุบกรอบ",
        image: "assets/images/229.jpg",
        price: 60,
        sold: 87,
      ),
    ];
  }
}
