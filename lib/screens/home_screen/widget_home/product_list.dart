import 'package:flutter/material.dart';
import 'package:khnomapp/model/product_model.dart';
import 'package:khnomapp/screens/product_detail_screen/product_detail.dart';
import 'package:khnomapp/utils/format.dart';
import 'package:khnomapp/viewmodels/product_model.dart';

class ProductLoadMore extends StatelessWidget {
  final List<ProductModel> _productViewModel = ProductViewModel().getProduct();

  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildProductList(),
        ],
      ),
    );
  }

  Column _buildProductList() => Column(
        children: [
          GridView.builder(
            padding: EdgeInsets.all(6),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _productViewModel.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.75,
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemBuilder: (BuildContext context, int index) {
              return ProductItemCard(_productViewModel[index], index);
            },
          ),
          // ignore: dead_code
          false ? SizedBox(height: 150) : BottomLoader(),
        ],
      );
}

class ProductItemCard extends StatelessWidget {
  final ProductModel product;
  final int index;

  const ProductItemCard(this.product, this.index);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            ProductDetail.routeName,
            arguments: ProductDetailArguments(product:product),
          ),
          // {
          //   print('${index}');
          //   print('click');
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => ProductDetail(),
          //     ),

          //   );
          // },
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    _buildProductImage(constraints.maxHeight),
                    _buildProductInfo(),
                  ],
                ),
              ),
              _buildProductPrice(),
              _buildProductSold(),
            ],
          ),
        );
      },
    );
  }

  Stack _buildProductImage(double maxHeight) {
    return Stack(
      children: <Widget>[
        Image.asset(
          product.image,
          height: maxHeight - 82,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        // if (product.discountPercentage != 0) _buildDiscount(),
        // if (product.mall) _buildMall(),
        // if (product.shopRecommended) _buildShopRecommended(),
      ],
    );
  }

  // Positioned _buildDiscount() => Positioned(
  //       right: 0,
  //       child: Container(
  //         height: 180,
  //         width: 38,
  //         child: CustomPaint(
  //           painter: DiscountPainter(),
  //           size: Size(35, 180),
  //           child: Column(
  //             children: [
  //               SizedBox(height: 3),
  //               Text(
  //                 "${product.discountPercentage}%",
  //                 style: TextStyle(
  //                   color: Colors.deepOrange,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 13,
  //                 ),
  //               ),
  //               Text(
  //                 "ลด",
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 12,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );

  // Container _buildMall() => Container(
  //       padding: EdgeInsets.all(2),
  //       decoration: BoxDecoration(
  //         color: Color(0xffd0011b),
  //         borderRadius: BorderRadius.circular(2),
  //       ),
  //       child: Text(
  //         "Mall",
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontWeight: FontWeight.bold,
  //           fontSize: 13,
  //         ),
  //       ),
  //     );

  // Container _buildShopRecommended() => Container(
  //       padding: EdgeInsets.all(2),
  //       decoration: BoxDecoration(
  //         color: Colors.deepOrange,
  //         borderRadius: BorderRadius.circular(2),
  //       ),
  //       child: Text(
  //         "ร้านแนะนำ",
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontWeight: FontWeight.bold,
  //           fontSize: 10,
  //         ),
  //       ),
  //     );

  Padding _buildProductInfo() => Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              child: _buildName(),
            ),
            SizedBox(height: 12),
          ],
        ),
      );

  Text _buildName() => Text(
        product.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

  RichText _buildPrice() => RichText(
        text: TextSpan(
          text: '\$ ',
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 12,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '${Format().currency(product.price, decimal: false)}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );

  Text _buildSold() => Text(
        "ขายได้ ${product.sold} ชิ้น",
        style: TextStyle(
          fontSize: 10,
        ),
      );

  Positioned _buildProductPrice() => Positioned(
        bottom: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              _buildPrice(),
            ],
          ),
        ),
      );

  Positioned _buildProductSold() => Positioned(
        bottom: 0,
        right: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              _buildSold(),
            ],
          ),
        ),
      );
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12, bottom: 22),
      width: double.infinity,
      alignment: Alignment.center,
      child: Center(
        child: Text(
          "กำลังโหลด",
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
