import 'package:flutter/material.dart';
import 'package:khnomapp/screens/account_screen/Account.dart';
import 'package:khnomapp/screens/cart_screeen/cart.dart';
import 'package:khnomapp/screens/home_screen/Home.dart';

class Nav extends StatefulWidget {
  static var routeName = '/nav';

  Nav({Key key}) : super(key: key);

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  List<Widget> _widgetOption = <Widget>[
    Home(),
    CartScreen(),
    Account(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOption.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.amber.shade800,
        unselectedItemColor: Colors.black38,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_sharp),
            label: 'location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity_sharp),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
