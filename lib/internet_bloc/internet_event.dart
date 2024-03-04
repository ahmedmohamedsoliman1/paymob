part of 'internet_bloc.dart';

@immutable
abstract class InternetEvent {}


class ConnectedEvent extends InternetEvent {}

class DisConnectedEvent extends InternetEvent {}
