import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khnomapp/model/main_manu_model.dart';
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
                          print("click");
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
