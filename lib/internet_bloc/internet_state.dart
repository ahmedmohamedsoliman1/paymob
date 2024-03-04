part of 'internet_bloc.dart';

@immutable
abstract class InternetState {}

class InternetInitial extends InternetState {}

class ChangeNetwork extends InternetState {

  final String connectivityStatus ;

  ChangeNetwork ({
    required this.connectivityStatus
});
}
