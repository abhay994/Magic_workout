import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference{
  SharedPreference._privateConstructor();
  static final SharedPreference instance = SharedPreference._privateConstructor();

  Future<String> getData()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return  (prefs.getString('JsonData')??'[]');
  }

  Future<void> setSetData({required String jsonData})async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     await (prefs.setString('JsonData',jsonData));
  }

}