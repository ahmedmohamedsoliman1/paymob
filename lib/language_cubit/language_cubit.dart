import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:testpayment/language_helper/language_helper.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());
  Future <void> getLanguage () async {
    LanguageHelper helper = LanguageHelper();
   String cachedLan = await helper.getLan();
    emit(ChangeLangState(newLang: cachedLan));
  }

  Future <void> changeLan (String newLan) async{
    LanguageHelper helper = LanguageHelper() ;
    await helper.saveLan(newLan);
    emit(ChangeLangState(newLang: newLan));
  }
}
