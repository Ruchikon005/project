import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerSlider extends StatefulWidget {
  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final List<String> _imgList = [
    'assets/images/five-healthy-foods-1.jpg',
    'assets/images/candy.jpg',
    'assets/images/experts_food_additives.jpg',
  ];

  int _current;

  @override
  void initState() {
    _current = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildBanner(),
        _buildIndicator(),
      ],
    );
  }

  Container _buildBanner() {
    return Container(
      width: double.infinity,
      child: CarouselSlider(
        options: CarouselOptions(
            aspectRatio: 1.873,
            viewportFraction: 1.0,
            // autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
              print('$index');
            }),
        items: _imgList
            .map(
              (item) => Image.asset(
                item,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            )
            .toList(),
      ),
    );
  }

  _buildIndicator() => Positioned(
        bottom: 8,
        child: Row(
          children: _imgList.map(
            (url) {
              int index = _imgList.indexOf(url);
              return Container(
                width: 8,
                height: _current == index ? 8 : 8,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index ? Colors.white : Colors.grey),
              );
            },
          ).toList(),
        ),
      );
}
