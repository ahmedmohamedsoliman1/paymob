import 'package:shared_preferences/shared_preferences.dart';

class LanguageHelper {

  /// save language chosen by user
  Future <void> saveLan (String newLan) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("LOCALE", newLan);
  }



  /// get language chosen by user
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