import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:testpayment/constants.dart';

class StripeManager {

  static Future <String> getClientId (String amount , String currency) async{
    Dio dio  = Dio() ;

    try {
      var response = await dio.post("https://api.stripe.com/v1/payment_intents" ,
          data: {
            "amount" : amount ,
            "currency" : currency
          } ,
          options: Options(
              headers: {
                'Authorization': 'Bearer ${Constants.secretKey}',
                'Content-Type': 'application/x-www-form-urlencoded'
              }
          )) ;

      return response.data ["client_secret"] ;
    }catch (e) {
      throw Exception(e);
    }
  }

  static Future<void>initializePaymentSheet(String clientSecret)async{
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: "Basel",
      ),
    );
  }

  static Future <void> makePayment (int amount , String currency) async{

    try {
      String clientSecret = await getClientId((amount * 100).toString(), currency) ;
      await initializePaymentSheet(clientSecret);
      await Stripe.instance.presentPaymentSheet();
    }catch (e) {
      throw Exception(e);
    }
    
  }

}