import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:testpayment/constants.dart';
import 'package:testpayment/counter_bloc/counter_bloc.dart';
import 'package:testpayment/counter_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testpayment/language_cubit/language_cubit.dart';

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
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CounterBloc()),
          BlocProvider(create: (context) => LanguageCubit()..getLanguage())
        ],
        child: BlocBuilder<LanguageCubit , LanguageState>(
            builder: (context , state) {
             if (state is LanguageInitial){
               return MaterialApp(
                 locale: Locale("en"),
                 localizationsDelegates: [
                   AppLocalizations.delegate, // Add this line
                   GlobalMaterialLocalizations.delegate,
                   GlobalWidgetsLocalizations.delegate,
                   GlobalCupertinoLocalizations.delegate,
                 ],
                 supportedLocales: [
                   Locale('en'), // English
                   Locale('ar'), // Spanish
                 ],
                 title: 'Flutter Demo' ,
                 initialRoute: "counter",
                 routes: {
                   "counter" : (context) => CounterScreen() ,
                   "home" : (context) => HomeScreen()
                 },
                 theme: ThemeData(
                   useMaterial3: false ,
                 ),
               );
             }else if (state is ChangeLangState){
               return MaterialApp(
                 locale: Locale(state.newLang),
                 localizationsDelegates: [
                   AppLocalizations.delegate, // Add this line
                   GlobalMaterialLocalizations.delegate,
                   GlobalWidgetsLocalizations.delegate,
                   GlobalCupertinoLocalizations.delegate,
                 ],
                 supportedLocales: [
                   Locale('en'), // English
                   Locale('ar'), // Spanish
                 ],
                 title: 'Flutter Demo' ,
                 initialRoute: "counter",
                 routes: {
                   "counter" : (context) => CounterScreen() ,
                   "home" : (context) => HomeScreen()
                 },
                 theme: ThemeData(
                   useMaterial3: false ,
                 ),
               );
             }else {
               return SizedBox();
             }
            }));
    }


}
