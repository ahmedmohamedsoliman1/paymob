import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:testpayment/constants.dart';

import 'home.dart';

void main() {

  Stripe.publishableKey = Constants.publishableKey ;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo' ,
      initialRoute: "home",
      routes: {
        "home" : (context) => HomeScreen()
      },
      theme: ThemeData(
        useMaterial3: false ,
      ),
    );
    }


}
