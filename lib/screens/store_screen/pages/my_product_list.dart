import 'dart:async';

import 'package:flutter/material.dart';
import 'package:khnomapp/config_ip.dart';
import 'package:http/http.dart' as http;
import 'package:khnomapp/model/myproduct_model.dart';
import 'package:khnomapp/model/product_model.dart';
import 'package:khnomapp/model/productfood_model.dart';
import 'package:khnomapp/screens/product_detail_screen/product_detail.dart';
import 'package:khnomapp/utils/format.dart';
import 'package:khnomapp/viewmodels/myproduct_list.dart';
import 'package:khnomapp/viewmodels/product_model.dart';
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class MyProduct extends StatefulWidget {
  static var routeName = '/my_product_list';

  const MyProduct({Key key}) : super(key: key);

  @override
  _MyProductState createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  // List<ProductModel>  _productViewModel = MyProductViewModel.getMyProduct();
  List<FoodModel>foodmodels = []; 
  static var body;
  static SharedPreferences prefs;
  Map<String, dynamic> profile = {
    'user_id': '',
    'username': '',
    'email': '',
    "role": ''
  };

  @override
  void initState() {
    super.initState();
    _getProfile();
    onGoBack(dynamic);
  }

  

  onGoBack(dynamic value) {
    setState(() {});
  }

  void _getProfile() async {
    prefs = await SharedPreferences.getInstance();
    var profileString = prefs.getString('profile');
    print(profileString);
    print('--------------------');
    if (profileString != null) {
      setState(() {
        profile = convert.jsonDecode(profileString);
      });
    }
  }

  // ignore: missing_return
  Future<String> getStoreDetail(String uid) async {
    var url = Uri.parse('${ConfigIp.domain}/stores/ownerfindstore/$uid');
    var response = await http.get(url);
    body = convert.jsonDecode(response.body);
    print(body);
    print('++++++++++');
    // await prefs.setString('ImageDetail', response.body);
    if (response.statusCode == 200) {
      print(body);
      print(body['store_id']);
      String stid = '${body['store_id']}';
      print('>>>>>>>>>>>>>>>>>>>');
      print(stid);
      return stid;
    } else {
      print(response.body);
    }
  }

  Future<String> getStore() async {
    // _getProfile();
    String data = await getStoreDetail('${profile['user_id']}');
    print('${profile['store_id']}');
    print('//////////////////////');
    print(data);
    return data;
  }

  // ignore: missing_return
  Future<String> getproduct() async {
    var data;
    var request = http.MultipartRequest(
        'GET', Uri.parse('${ConfigIp.domain}/products/productlist/${await getStore()}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      data = await response.stream.bytesToString();
      print('data................');
      print(data);

      for(var map in data){
        // FoodModel foodModel = FoodModel.fromj(map);
        setState(() {
          // foodmodels.add(foodModel);
        });
      }

    } else {
      print(response.reasonPhrase);
    }
    // return data.toString();
  }

  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Product(),
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
            // itemCount: MyProductViewModel.getMyProduct( ).length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.75,
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemBuilder: (BuildContext context, int index) {
            return ProductItemCard(foodmodels[index], index);
            },
          ),
          // ignore: dead_code
          false ? SizedBox(height: 150) : BottomLoader(),
        ],
      );
}

class ProductItemCard extends StatelessWidget {
  // final ProductModel product;
  final FoodModel food;
  final int index;

  const ProductItemCard(this.food, this.index);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            ProductDetail.routeName,
            // arguments: ProductDetailArguments(food:food),
          ),
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
        // NetworkImage(
        //   '${ConfigIp.domain}/${foodModels[index].image_path}',
        //   // height: maxHeight - 82,
        //   // width: double.infinity,
        //   // fit: BoxFit.cover,
        // ),
      ],
    );
  }

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
        food.product_name,
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
            // TextSpan(
            //   text: '${Format().currency(food.price, decimal: false)}',
            //   style: TextStyle(
            //     fontSize: 16,
            //   ),
            // ),
          ],
        ),
      );

  Text _buildSold() => Text(
        "ขายได้ ${food.quantity} ชิ้น",
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




  

