part of 'counter_bloc.dart';

@immutable
abstract class CounterState {}

class CounterInitial extends CounterState {}

class CounterChangeValue extends CounterState {
  final int counter ;

  CounterChangeValue({
    required this.counter
});

}
