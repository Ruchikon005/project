import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'ads_promotions.dart';

class BodyHome extends StatelessWidget {
  const BodyHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [AdsPromotions(), Categories()],
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Flash Icon.svg", "text": "Flash Deal"},
      {"icon": "assets/icons/Flash Icon.svg", "text": "Flash Deal"},
      {"icon": "assets/icons/Flash Icon.svg", "text": "Flash Deal"},
      {"icon": "assets/icons/Flash Icon.svg", "text": "Flash Deal"},
      {"icon": "assets/icons/Flash Icon.svg", "text": "Flash Deal"},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(
            categories.length,
            (index) => CategoriesCard(
                  icon: categories[index]["icon"],
                  text: categories[index]["text"],
                  prass: () {},
                ))
      ],
    );
  }
}

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({
    Key key,
    // @required this.categories,
    @required this.icon,
    @required this.text,
    @required this.prass,
  }) : super(key: key);

  // final List<Map<String, dynamic>> categories;
  final String icon, text;
  final GestureTapCallback prass;

  @override
  Widget build(BuildContext context) {
    return 
          GestureDetector(
            onTap: prass,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 50,
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(icon),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(text, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
         
    );
  }
}
