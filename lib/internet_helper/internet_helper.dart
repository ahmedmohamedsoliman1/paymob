import 'package:connectivity_plus/connectivity_plus.dart';

class InternetHelper {

   Future <String> showConnectivity () async{
     final connectivityResult = await Connectivity().checkConnectivity();

     if (connectivityResult == ConnectivityResult.wifi){
       return "Connected" ;
     }else if (connectivityResult == ConnectivityResult.mobile){
       return "Not Connected" ;
     }else {
       return "" ;
     }
   }

}