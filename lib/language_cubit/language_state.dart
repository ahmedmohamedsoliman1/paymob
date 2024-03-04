part of 'language_cubit.dart';

@immutable
abstract class LanguageState {}

class LanguageInitial extends LanguageState {}

class ChangeLangState extends LanguageState {

  final String newLang ;

  ChangeLangState ({
    required this.newLang
});
}
