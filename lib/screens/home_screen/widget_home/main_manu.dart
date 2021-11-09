import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khnomapp/model/main_manu_model.dart';
import 'package:khnomapp/screens/category_allscreen/page/cate1.dart';
import 'package:khnomapp/screens/category_allscreen/page/cate2.dart';
import 'package:khnomapp/screens/category_allscreen/page/cate3.dart';
import 'package:khnomapp/screens/category_allscreen/page/cate4.dart';
import 'package:khnomapp/screens/category_allscreen/page/cate5.dart';
import 'package:khnomapp/screens/category_allscreen/page/cate6.dart';
import 'package:khnomapp/viewmodels/main_menu_viewmodel.dart';

class MainManu extends StatelessWidget {
  final List<MainMenuModel> _menus = MainMenuViewModel().getMainMenu();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.centerLeft,
            height: 30,
            child: Text(
              "หมวดหมู่",
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 145,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisExtent: 98,
              ),
              itemBuilder: (context, index) {
                final MainMenuModel menu = _menus[index];
                return Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.black45,
                          padding: EdgeInsets.all(8),
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            // side: BorderSide(color: Colors.grey),
                          ),
                        ),
                        onPressed: () {
                          index == 0 ? Navigator.pushNamed(context,Cate1.routeName): null;
                          index == 1 ? Navigator.pushNamed(context,Cate2.routeName): null;
                          index == 2 ? Navigator.pushNamed(context,Cate3.routeName): null;
                          index == 3 ? Navigator.pushNamed(context,Cate4.routeName): null;
                          index == 4 ? Navigator.pushNamed(context,Cate5.routeName): null;
                          index == 5 ? Navigator.pushNamed(context,Cate6.routeName): null;
                        },
                        child: SvgPicture.asset(
                          menu.icon,
                          color: menu.color,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      menu.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
              itemCount: _menus.length,
            ),
          ),
        ],
      ),
    );
  }
}
