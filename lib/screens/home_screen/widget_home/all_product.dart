import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khnomapp/config_ip.dart';
import 'package:khnomapp/model/myproduct_model.dart';
import 'package:khnomapp/model/user_image_model.dart';
import 'package:khnomapp/screens/product_detail_screen/product_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class AllProduct extends StatefulWidget {
  
  const AllProduct({Key key}) : super(key: key);
  @override
  _AllProductState createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  // bool check = Bool;
  static SharedPreferences prefs;
  Map<String, dynamic> profile = User.profile;
  int indexWidget = 0;
  List<Myproduct> foodModel = [];

  @override
  void initState() {
    super.initState();
    getProfile();
    readApiProduct();
  }

  // @override
  // void setState(VoidCallback fn) {
  //   // ignore: todo
  //   // TODO: implement setState
  //   super.setState(fn);
  //   setState(() {});
  // }

  void getProfile() async {
    prefs = await SharedPreferences.getInstance();
    var profileString = prefs.getString('profile');
    if (profileString != null) {
      setState(() {
        profile = convert.jsonDecode(profileString);
        print(profile['user_id']);
      });
    }
  }

  // ignore: missing_return
  Future<Null> readApiProduct() async {
    var url = Uri.parse('${ConfigIp.domain}/products/productlist');
    final response = await http.get(url);
    print(response.body);
    var res = convert.jsonDecode(response.body);
    for (var item in res) {
      Myproduct food = Myproduct.fromJson(item);
      print('name ---> ${food.price}');
      setState(() {
        foodModel.add(food);
      });
    }

    // return compute(parseFood, response.body);
  }

  onGoBack(dynamic value) {
    setState(() {});
  }

  Widget build(BuildContext context) {
    final weightScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    final f = NumberFormat("###.00");
    return GridView.builder(
      padding: EdgeInsets.all(6),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: foodModel.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.75,
        crossAxisCount: 2,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
      ),
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            ProductDetail.routeName,
            arguments: foodModel[index],
          ),
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                // height: 300,
              ),
              Column(
                children: [
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              '${ConfigIp.domain}/${foodModel[index].image_path}',
                              scale: heightScreen - 82),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            foodModel[index].product_name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '\$ ',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 12,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${foodModel[index].price}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "??????????????? ${foodModel[index].quantity} ????????????",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              // Text(foodModel[index].)
            ],
          ),
        );
      },
    );
  }
}
