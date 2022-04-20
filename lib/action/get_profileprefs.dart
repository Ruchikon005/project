import 'package:khnomapp/model/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

Future getProfile() async {
    var prefs = await SharedPreferences.getInstance();
    var profileString = prefs.getString('profile');
    Profile pro = Profile();
    // print(profileString);
    if (profileString != null) {
        Map<String, dynamic> profile = convert.jsonDecode(profileString);
        pro = Profile.fromJson(profile);
        print(pro.username);
        return pro;
    }
    
}