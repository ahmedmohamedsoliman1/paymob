import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testpayment/payment_manager/payment_manager.dart';
import 'package:testpayment/payment_manager/stripe_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text ("Paymob integration"),
        centerTitle: true,
      ),

      body: Center(
        child: ElevatedButton(
            onPressed: () async{
             await pay();
            }, child: const Text("Pay 10 EGP")),
      ),
    );
  }


   /// paymob
  Future <void> pay () async {
    PaymentManager paymentManager = PaymentManager();
    await paymentManager.authenticationRequest().then((value) async{
      await paymentManager.orderRegistrationAPI();
    }).then((value) async{
      await paymentManager.getPaymentToken().then((String paymentToken) async{
        var url = Uri.parse("https://accept.paymob.com/api/acceptance/iframes/829140?payment_token=$paymentToken");
        await launchUrl(url);
      });
    });
  }

  /// stripe

  Future <void> makePayment () async{
    await StripeManager.makePayment(20, "EGP") ;
  }
}