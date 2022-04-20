
import 'package:flutter/material.dart';

class AddLocation extends StatefulWidget {
  static var routeName = '/add_location';
  AddLocation({Key key}) : super(key: key);

  @override
  _AddlocationState createState() => _AddlocationState();
}

class _AddlocationState extends State<AddLocation> {
  TextEditingController _category = TextEditingController();

  List<String> options = <String>[
    'กระบี่',
    'กรุงเทพมหานคร',
    'กาญจนบุรี',
    'กาฬสินธุ์',
    'กำแพงเพชร',
    'ขอนแก่น',
    'จันทบุรี',
    'ฉะเชิงเทรา',
    'ชลบุรี',
    'ชัยนาท',
    'ชัยภูมิ',
    'ชุมพร',
    'เชียงราย',
    'เชียงใหม่',
    'ตรัง',
    'ตราด',
    'ตาก',
    'นครนายก',
    'นครปฐม',
    'นครพนม',
    'นครราชสีมา',
    'นครศรีธรรมราช',
    'นครสวรรค์',
    'นนทบุรี',
    'นราธิวาส',
    'น่าน',
    'บึงกาฬ',
    'บุรีรัมย์',
    'ปทุมธานี',
    'ประจวบคีรีขันธ์',
    'ปราจีนบุรี',
    'ปัตตานี',
    'พะเยา',
    'พระนครศรีอยุธยา',
    'พังงา',
    'พัทลุง',
    'พิจิตร',
    'พิษณุโลก',
    'เพชรบุรี',
    'เพชรบูรณ์',
    'แพร่',
    'ภูเก็ต',
    'มหาสารคาม',
    'มุกดาหาร',
    'แม่ฮ่องสอน',
    'ยโสธร',
    'ยะลา',
    'ร้อยเอ็ด',
    'ระนอง',
    'ระยอง',
    'ราชบุรี',
    'ลพบุรี',
    'ลำปาง',
    'ลำพูน',
    'เลย	',
    'ศรีสะเกษ',
    'สกลนคร',
    'สงขลา',
    'สตูล',
    'สมุทรปราการ',
    'สมุทรสงคราม',
    'สมุทรสาคร',
    'สระแก้ว',
    'สระบุรี',
    'สิงห์บุรี',
    'สุโขทัย',
    'สุพรรณบุรี',
    'สุราษฎร์ธานี',
    'สุรินทร์',
    'หนองคาย',
    'หนองบัวลำภู',
    'อ่างทอง',
    'อำนาจเจริญ',
    'อุดรธานี',
    'อุตรดิตถ์',
    'อุทัยธานี',
    'อุบลราชธานี',
  ];
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตั้งค่าการจัดส่ง'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            height: 150,
            width: double.infinity,
            color: Colors.grey,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      child: Text('เลือกจังหวัด'),
                    ),
                    Container(
                      // alignment: Alignment.centerRight,
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                            _category.text = dropdownValue;
                            print(_category.text);
                          });
                        },
                        underline: Container(),
                        hint: Container(
                            alignment: Alignment.centerRight,
                            width: 180,
                            child: Text("จังหวัด",
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.end)),
                        selectedItemBuilder: (BuildContext context) {
                          return options.map<Widget>((String item) {
                            return Container(
                                alignment: Alignment.centerRight,
                                width: 180,
                                child:
                                    Text(item, style: TextStyle(fontSize: 15)));
                          }).toList();
                        },
                        items: options
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(fontSize: 15)),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                
                Row(
                  children: [
                    Text("เพิ่มสถานที่"),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
