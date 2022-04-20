import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:khnomapp/action/get_mycart.dart';
import 'package:khnomapp/action/get_profileprefs.dart';
import 'package:khnomapp/config_ip.dart';
import 'package:khnomapp/main.dart';
import 'package:khnomapp/model/location_model.dart';
import 'package:khnomapp/model/productfood_model.dart';
import 'package:khnomapp/model/profile_model.dart';
import 'package:khnomapp/screens/cart_screeen/widget_cart/botton_widget.dart';
import 'package:khnomapp/screens/cart_screeen/widget_cart/dialog_alert_widget.dart';
import 'package:khnomapp/screens/cart_screeen/widget_cart/showmap.dart';
import 'package:khnomapp/screens/creditcard_screen/creditcard.dart';
import 'package:khnomapp/screens/payment_screen/payment.dart';
import 'package:khnomapp/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class CartScreen extends StatefulWidget {
  static var routeName = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController _showLo = TextEditingController();
  Position userLocation;
  static SharedPreferences prefs;
  FoodModel foodModel = FoodModel();
  List<LocationModel> locationModel = [];
  int indexWidget = 0;
  int quantity = 1;
  int total;

  Map<String, dynamic> profile = {
    'user_id': '',
    'username': '',
    'email': '',
    "role": ''
  };

  List<String> payM = <String>['เงินสด', 'credit card'];
  List<String> clock = <String>[
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17'
  ];
  List<String> minute = <String>['00', '30'];
  String dropdownValueClock = '';
  String dropdownValueMinute = '';
  String dropdownValuePay = '';
  String howPay;
  bool checkMap = false;
  String timeClock = '';
  String timeMinute = '';
  bool checkTime = false;
  DateTime date;
  String dateFormatted;
  String dateMatFinal;


  String getDate() {
    if (date == null) {
      return 'Select Date';
    } else {
      dateMatFinal = DateFormat('dd/MM/yyyy').format(date);
      return dateMatFinal;
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  TimeOfDay time;

  Future myfuture;
  LocationModel dropdownValue = LocationModel();
  LocationModel newValue = LocationModel();
  LatLng locat;
  String namelocation;
  // String dropdownValue;

  @override
  void initState() {
    // TODO: implement initState
    myfuture = _getProfile();
    super.initState();
  }

  Future _getProfile() async {
    prefs = await SharedPreferences.getInstance();
    var profileString = prefs.getString('profile');
    print(profileString);
    if (profileString != null) {
      setState(() {
        profile = convert.jsonDecode(profileString);
      });
    }
    await getMyCart();
    return true;
  }

  Future getMyCart() async {
    String uid = profile['user_id'].toString();
    print(uid);
    var url = Uri.parse('${ConfigIp.domain}/cart/mycart/$uid');
    final response = await http.get(url);
    print(response.body);
    var res = convert.jsonDecode(response.body);
    foodModel = FoodModel.fromJson(res);
    print(foodModel.product_id);
    setState(() {
      total = foodModel.price;
    });
    await getLcation();
  }

  Future getLcation() async {
    var url = Uri.parse(
        '${ConfigIp.domain}/location/findbyitem/${foodModel.product_id}');
    final response = await http.get(url);
    print(response.body);
    var res = json.decode(response.body);
    for (var item in res) {
      LocationModel loca = LocationModel.fromJson(item);
      setState(() {
        locationModel.add(loca);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final weightScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: Text('My Cart'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
          future: myfuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                    '${ConfigIp.domain}/${foodModel.image_path}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  foodModel.product_name,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  foodModel.product_detail,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              Text(
                                'เลือกสถานที่นัดรับ',
                                style: TextStyle(fontSize: 18),
                              ),
                              DropdownButton<LocationModel>(
                                value: dropdownValue.location_name != null
                                    ? dropdownValue
                                    : null,
                                underline: Container(),
                                hint: Container(
                                    alignment: Alignment.centerRight,
                                    width: 180,
                                    child: Text("เลือก",
                                        style: TextStyle(fontSize: 15),
                                        textAlign: TextAlign.end)),
                                selectedItemBuilder: (BuildContext context) {
                                  return locationModel.map<Widget>(
                                      (LocationModel locationModel) {
                                    return Container(
                                        alignment: Alignment.centerRight,
                                        width: 180,
                                        child: Text(locationModel.location_name,
                                            style: TextStyle(fontSize: 15)));
                                  }).toList();
                                },
                                items: locationModel
                                    .map<DropdownMenuItem<LocationModel>>(
                                        (LocationModel locationModel) {
                                  return DropdownMenuItem<LocationModel>(
                                    value: locationModel,
                                    child: Text(locationModel.location_name,
                                        style: TextStyle(fontSize: 15)),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                    namelocation = dropdownValue.location_name;
                                    checkMap = true;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'รายละเอียดสถานที่',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            children: [
                              dropdownValue.location_detail != null
                                  ? Text(
                                      '-- ' + dropdownValue.location_detail,
                                      style: TextStyle(fontSize: 18),
                                    )
                                  : Text(
                                      '--',
                                      style: TextStyle(fontSize: 18),
                                    )
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        showmap(dropdownValue),
                        SizedBox(height: 30),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              ButtonHeaderWidget(
                                title: 'วันที่',
                                text: getDate(),
                                onClicked: () => pickDate(context),
                              ),
                              ButtonHeaderWidget(
                                title: 'เวลา',
                                text: timeClock.isEmpty || timeMinute.isEmpty
                                    ? 'Select Time'
                                    : '$timeClock : $timeMinute',
                                onClicked: () async {
                                  await selectTime(context);
                                  timeClock.isEmpty || timeMinute.isEmpty
                                      ? checkTime = false
                                      : checkTime = true;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  quantity == 1
                                      ? null
                                      : quantity = quantity - 1;
                                  total = foodModel.price * quantity;
                                });
                              },
                              child: Icon(
                                Icons.horizontal_rule,
                                size: 30,
                                color: Colors.black54,
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(12),
                                  primary: Colors.white,
                                  side: BorderSide(
                                      color: Colors.black54, width: 1.0)),
                            ),
                            SizedBox(width: 15),
                            Text(
                              '${quantity}',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 15),
                            ElevatedButton(
                              onPressed: () {
                                print(foodModel.quantity);
                                setState(() {
                                  quantity == foodModel.quantity
                                      ? null
                                      : quantity = quantity + 1;
                                  total = foodModel.price * quantity;
                                });
                              },
                              child: Icon(
                                Icons.add,
                                size: 30,
                                color: Colors.black54,
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(12),
                                  primary: Colors.white,
                                  side: BorderSide(
                                      color: Colors.black54, width: 1.0)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 30),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'จำนวน',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${quantity}',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    'ราคารวม',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  quantity == 1
                                      ? Text(
                                          '${foodModel.price}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          '${total}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )
                                ],
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, CreditCardScreen.routeName);
                          },
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(color: Colors.black26),
                                    bottom: BorderSide(color: Colors.black26))),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.monetization_on_outlined,
                                  color: Colors.orangeAccent.shade700,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'ตั้งค่าการขำระเงิน',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Spacer(),
                                DropdownButton<String>(
                                  value: dropdownValuePay == ''
                                      ? null
                                      : dropdownValuePay,
                                  onChanged: (String value) => setState(() {
                                    print(value);
                                    dropdownValuePay = value;
                                    howPay = dropdownValuePay;
                                  }),
                                  underline: Container(),
                                  hint: Container(
                                      alignment: Alignment.centerRight,
                                      width: 60,
                                      child: Text("เลือก",
                                          style: TextStyle(fontSize: 15),
                                          textAlign: TextAlign.end)),
                                  selectedItemBuilder: (BuildContext context) {
                                    return payM.map<Widget>((String item) {
                                      return Container(
                                          alignment: Alignment.centerRight,
                                          width: 90,
                                          child: Text(item));
                                    }).toList();
                                  },
                                  items: payM.map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 80,
                      color: Colors.white,
                      child: InkWell(
                          onTap: total == null
                              ? total = foodModel.price
                              : () {
                                  print(total);
                                  String amount;
                                  setState(() {
                                    amount = total.toString();
                                  });
                                  if (checkMap == true) {
                                    if (dateFormatted == null) {
                                      print('กรุณาเลือกวันที่นัดรับ');
                                      _alertdialogisEmty(context);
                                      print(checkTime);
                                    } else {
                                      if (checkTime == false) {
                                        print('กรุณาเลือกเวลานัดรับ');
                                        _alertdialogisEmty(context);
                                      } else {
                                        String timeFinal ='$timeClock:$timeMinute';
                                        if (howPay == 'เงินสด') {
                                          print(howPay);
                                        } else if (howPay == 'credit card') {
                                          print(howPay);
                                          print(foodModel.stid);
                                          Navigator.pushNamed(
                                              context, PaymentScreen.routeName,
                                              arguments: ScreenArguments(amount,quantity.toString(), foodModel.product_id,dateMatFinal, timeFinal, namelocation,foodModel.stid));
                                        } else {
                                          print('กรุณาเลือกวิธีชำระเงิน');
                                          _alertdialogisEmty(context);
                                        }
                                      }
                                    }
                                  } else {
                                    print('กรุณาเลือกสถานที่');
                                    _alertdialogisEmty(context);
                                  }

                                  // showHowpay();
                                },
                          child: Container(
                            decoration: BoxDecoration(
                                color: MyStyle().colorCustom,
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ชำระเงิน',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
          }),
    );
  }

  Future<dynamic> _alertdialogisEmty(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          Timer(Duration(seconds: 2), () {
            Navigator.of(context, rootNavigator: true).pop();
          });
          return AlertDialog(
            title: Text(
              'กรุณากรอกข้อมูลให้ครบ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
        });
  }

  Future selectTime(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DropdownButton<String>(
                        iconSize: 0.0,
                        icon: Icon(null),
                        value: dropdownValueClock == ''
                            ? null
                            : dropdownValueClock,
                        onChanged: (String value) => setState(() {
                          print(value);
                          dropdownValueClock = value;
                          // timeClock = dropdownValueClock;
                        }),
                        underline: Container(),
                        hint: Container(
                            alignment: Alignment.centerRight,
                            child: Text("00",
                                style: TextStyle(fontSize: 24),
                                textAlign: TextAlign.end)),
                        selectedItemBuilder: (BuildContext context) {
                          return clock.map<Widget>((String item) {
                            return Container(
                                alignment: Alignment.centerRight,
                                child:
                                    Text(item, style: TextStyle(fontSize: 24)));
                          }).toList();
                        },
                        items: clock.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                      SizedBox(width: 20),
                      Text(
                        ':',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 20),
                      DropdownButton<String>(
                        iconSize: 0.0,
                        icon: Icon(null),
                        value: dropdownValueMinute == ''
                            ? null
                            : dropdownValueMinute,
                        onChanged: (String value) => setState(() {
                          print(value);
                          dropdownValueMinute = value;
                          // timeMinute = dropdownValueMinute;
                        }),
                        underline: Container(),
                        hint: Container(
                            alignment: Alignment.centerRight,
                            child: Text("00",
                                style: TextStyle(fontSize: 24),
                                textAlign: TextAlign.end)),
                        selectedItemBuilder: (BuildContext context) {
                          return minute.map<Widget>((String item) {
                            return Container(
                                alignment: Alignment.centerRight,
                                child:
                                    Text(item, style: TextStyle(fontSize: 24)));
                          }).toList();
                        },
                        items: minute.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ],
                  )),
              actions: [
                TextButton(
                  child: new Text("ตกลง",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 97, 97, 97))),
                  onPressed: () async {
                    await setTime();
                    print('$timeClock : $timeMinute');
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
        });
  }

  setTime() {
    setState(() {
      timeClock = dropdownValueClock;
      timeMinute = dropdownValueMinute;
    });
  }

  showHowpay() {
    showBottomSheet(
        backgroundColor: Color.fromARGB(0, 167, 6, 0),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              color: Color(0xff232f34),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      height: 80,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    DateTime now = DateTime.now();
    int lastday = DateTime(now.year, now.month, 0).day;
    print(now);
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: now,
      lastDate: DateTime(now.year - 2, lastday - 2, now.day + 2),
      // lastDate: DateTime(now.day),
    );

    if (newDate == null) return;
    setState(() {
      print(newDate);
      dateFormatted = DateFormat('dd/MM/yyyy').format(newDate);
      print(dateFormatted);
    });
    setState(() => date = newDate);
  }
}

class ScreenArguments {
  final String amount;
  final String qauntity;
  final int product_id;
  final String dateMatFinal;
  final String timeFinal;
  final String namelocation;
  final int stid;


  ScreenArguments(this.amount, this.qauntity, this.product_id, this.dateMatFinal, this.timeFinal, this.namelocation, this.stid);
}
