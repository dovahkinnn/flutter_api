import 'package:flutterweb/models/user.dart';

// ignore: unused_import
import 'dart:convert' as convert;

 import 'package:http/http.dart' as http;




class UserService {
  static String _url = 'https://api.binance.com/api/v3/ticker/price';
  static Future browse() async {
    
  List collection;
    List<User> _contacts;
    var response = await http.get(_url);
    if (response.statusCode == 200) {
      collection = convert.jsonDecode(response.body);
      _contacts = collection.map((json) => User.fromJson(json)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return _contacts;
    
  }
}
