import 'package:flutter/cupertino.dart';

class LanguageProvider with ChangeNotifier{
  Locale _locale = const Locale("en");

  Locale get locale => _locale;
  void changeLocale(String _local) {
    _locale = Locale(_local);
    notifyListeners();
  }
}