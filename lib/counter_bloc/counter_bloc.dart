import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int counter = 0 ;
  CounterBloc() : super(CounterInitial()) {
    on<CounterEvent>((event, emit) {
     if (event is IncrementCounter) {
       counter = counter + 1 ;
       print(counter);
       emit(CounterChangeValue(counter: counter));
     }else if (event is DecrementCounter) {
       counter = counter  - 1 ;
       print(counter);
       emit(CounterChangeValue(counter: counter)) ;
     }else {
       counter = 0 ;
       print(counter);
       emit (CounterChangeValue(counter: counter)) ;
     }
    });
  }
}
