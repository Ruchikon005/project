import 'package:flutter/material.dart';
import 'package:khnomapp/model/main_manu_model.dart';

class MainMenuViewModel {
  List<MainMenuModel> getMainMenu() {
    return [
      MainMenuModel(
        icon:
            "assets/icons/pngegg_1_.svg",
        title: "ขนมขบเคี้ยว",
        // color: Colors.black,
      ),
      MainMenuModel(
        icon:
            "assets/icons/pngwing.com.svg",
        title: "อาหารเพื่อสุขภาพ",
        // color: Colors.cyan,
      ),
      MainMenuModel(
        icon:
            "assets/icons/anw0g-b2nks.svg",
        title: "เบเกอรี่",
        // color: Colors.red,
      ),
      MainMenuModel(
        icon:
            "assets/icons/Pngtree226128148summer_drink_4640986.svg",
        title: "เครื่องดื่ม",
        // color: Colors.blue,
      ),
      MainMenuModel(
        icon:
            "assets/icons/LOGO-OTOP.svg",
        title: "ผลิตภัทณ์ OTOP",
        color: Colors.brown.shade700,
      ),
      MainMenuModel(
        icon:
            "assets/icons/7168837_candy_icon.svg",
        title: "Candy",
        // color: Colors.blue,
      ),
     
    ];
  }
}