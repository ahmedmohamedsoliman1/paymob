import 'package:dio/dio.dart';
import 'package:testpayment/constants.dart';

class PaymentManager {

  Dio dio = Dio() ;

  Future <String> authenticationRequest () async {
    var path = "https://accept.paymob.com/api/auth/tokens" ;
    try {
      var response = await dio.post(path , data: {
        "api_key" : Constants.paymentKey
      }) ;
      print(response.data["token"]) ;
      return response.data["token"] ;
    }catch (e) {
      print("ex1 : $e");
      throw Exception() ;
    }
  }

  Future <int> orderRegistrationAPI () async{
    var path = "https://accept.paymob.com/api/ecommerce/orders" ;
    try {
      var response = await dio.post(path , data: {
        "auth_token" : await authenticationRequest(),
        "delivery_needed" : "false" ,
        "amount_cents": "100",  /// *100 for pound
        "currency": "EGP",
        "items": [
          {
            "name": "ASC1515",
            "amount_cents": "500000",
            "description": "Smart Watch",
            "quantity": "1"
          },
          {
            "name": "ERT6565",
            "amount_cents": "200000",
            "description": "Power Bank",
            "quantity": "1"
          }
        ],
      });
      print(response.data["id"]) ;
      return response.data["id"] ;
    }catch (e) {
      print("ex2 : $e") ;
      throw Exception();
    }
  }

  Future <String> getPaymentToken () async {

    var path = "https://accept.paymob.com/api/acceptance/payment_keys" ;
   try {
     var response = await dio.post(path , data: {
       "auth_token": await authenticationRequest(),
       "amount_cents": "100",
       "expiration": 3600,
       "order_id": await orderRegistrationAPI(),
       "currency": "EGP",
       "billing_data": {
         "apartment": "803",
         "email": "ahmedellewaa22@gmail.com",
         "floor": "42",
         "first_name": "Ahmed",
         "street": "Alex",
         "building": "8028",
         "phone_number": "+201555755621",
         "shipping_method": "PKG",
         "postal_code": "01898",
         "city": "Jaskolskiburgh",
         "country": "EG",
         "last_name": "Soliman",
         "state": "Utah"
       },
       "integration_id": Constants.integrationId,

     });

     return response.data["token"] ;
   }catch (e) {
     print("ex3 : $e");
     throw Exception();
   }

  }


}