import 'package:shared_preferences/shared_preferences.dart';

class LanguageHelper {

  Future <void> saveLan (String newLan) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("LOCALE", newLan);
  }

  Future <String> getLan () async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
   String? cachedLan =  preferences.getString("LOCALE");
    if (cachedLan != null){
      return cachedLan ;
    }else {
      return "en" ;
    }
  }
}