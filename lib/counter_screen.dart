import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testpayment/counter_bloc/counter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testpayment/internet_bloc/internet_bloc.dart';
import 'package:testpayment/language_cubit/language_cubit.dart';
import 'package:testpayment/language_helper/language_helper.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});


  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloc example"),
        centerTitle: true,
      ),
      body: Center(
        child: BlocConsumer<InternetBloc , InternetState>(
          listener: (context , state) {
            if (state is ChangeNetwork){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.connectivityStatus)));
            }
          },
            builder: (context , state) {
              if (state is ChangeNetwork){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.connectivityStatus , style: TextStyle(
                        color: Colors.black , fontSize: 20 , fontWeight: FontWeight.bold
                    ),) ,
                    const Text("Counter" , style: TextStyle(
                        color: Colors.black , fontSize: 20 , fontWeight: FontWeight.bold
                    ),) ,
                    const SizedBox(height: 10,),
                    BlocBuilder<CounterBloc , CounterState>(
                        builder: (context , state) {
                          if (state is CounterInitial){
                            print("init");
                            return Text("0" , style: TextStyle(
                                fontSize: 18 ,
                                fontWeight: FontWeight.bold
                            ),);
                          }else if (state is CounterChangeValue){
                            print("not init");
                            print(state.counter.toString());
                            return Text(state.counter.toString() , style: TextStyle(
                                fontSize: 18 ,
                                fontWeight: FontWeight.bold
                            ),);
                          }else {
                            return Container();
                          }
                        }),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(onPressed: () {
                          bloc.add(IncrementCounter());
                          print("add");
                        }, child: const Icon(Icons.add)) ,
                        ElevatedButton(onPressed: () {
                          bloc.add(ResetCounter());
                          print("reset");
                        }, child: const Icon(Icons.exposure_zero)),
                        ElevatedButton(onPressed: () {
                          bloc.add(DecrementCounter());
                          print("minus");
                        }, child: const Icon(Icons.minimize)),

                      ],
                    ),
                    const SizedBox(height: 10,),
                    BlocConsumer<LanguageCubit , LanguageState>(
                        listener: (context , state) {
                          if (state is ChangeLangState){
                            Navigator.pushNamed(context, "home");
                          }
                        },
                        builder: (context , state) {
                          if (state is ChangeLangState){
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width : 150 ,
                                  child: ElevatedButton(onPressed: () async{
                                    BlocProvider.of<LanguageCubit>(context).changeLan("ar");
                                  }, child: Text (AppLocalizations.of(context)!.changelocalear)),
                                ),
                                const SizedBox(width: 10,),
                                SizedBox(
                                  width : 150 ,
                                  child: ElevatedButton(onPressed: () async{
                                    BlocProvider.of<LanguageCubit>(context).changeLan("en");
                                  }, child: Text (AppLocalizations.of(context)!.changelocaleen)),
                                )
                              ],
                            );
                          }else {
                            return const SizedBox();
                          }
                        })
                  ],
                ) ;
              }else {
                return SizedBox();
              }
            }),
      ),
    );
  }
}

