import 'package:flutter/material.dart';
import 'package:khnomapp/screens/account_screen/Account.dart';
import 'package:khnomapp/screens/cart_screeen/cart.dart';
import 'package:khnomapp/screens/home_screen/Home.dart';

class NavStore extends StatefulWidget {
  static var routeName = '/nav_store';

  NavStore({Key key}) : super(key: key);

  @override
  _NavStoreState createState() => _NavStoreState();
}

class _NavStoreState extends State<NavStore> {
  int _selectedIndex = 0;
  List<Widget> _widgetOption = <Widget>[
    Text('data1'),
    Text('data2'),
    Text('data3'),
  ];

  void _onItemTap(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            var count = 0;
            Navigator.popUntil(context, (route) {
              return count++ == 2;
            });
          },
        ),
        actions: [],
        title: Text(
          'My Store',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [Container(
            height: 200,
            color: Colors.white,
            width: double.infinity,
            child: Stack(children: [
              Column(children: [
                SizedBox(height: 40),
                // _profileImage(),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Store name',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ]),
            ]),
          ),
            Center(child: _widgetOption.elementAt(_selectedIndex)),
          ],
        ),
      ),
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
            label: 'Order',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
