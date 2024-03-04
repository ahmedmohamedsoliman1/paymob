import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {

  StreamSubscription? subscription ;
  InternetBloc() : super(InternetInitial()) {
    on<InternetEvent>((event, emit) {
       if (event is ConnectedEvent){
         emit(ChangeNetwork(connectivityStatus: "Connected")) ;
       }else if (event is DisConnectedEvent){
         emit(ChangeNetwork(connectivityStatus: "Not Connected")) ;
       }
    });

    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile){
        add(ConnectedEvent());
      }else {
        add(DisConnectedEvent());
      }
    });

  }
  @override
  Future<void> close() {
    subscription!.cancel();
    return super.close();
  }
}
