
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class search_bar extends StatelessWidget {
  const search_bar({
    Key key,
    @required TextEditingController textEditingController,
  })  : _textEditingController = textEditingController,
        super(key: key);

  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
      child: TextField(
        onChanged: (value) {
          //search value
        },
        controller: _textEditingController,
        decoration: InputDecoration(
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.all(10),
            hintText: 'Search product'),
      ),
    );
  }
}
