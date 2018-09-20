import 'dart:async';
import 'dart:collection';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/term.dart';

class AppSettings {
  static const String _kSignedInKey = "is_sign_in";
  static const String _kAutoGetKey = "auto_get";
  static const String _kShowAdsKey = "show_ads";
  static const String _kTermsKey = "terms";
  static const String _kPeriod = "period";
  static const String _kSelectedTermKey = "selected_term";

  static AppSettings _appSettings;

  final SharedPreferences _sharedPreferences;

  const AppSettings(this._sharedPreferences);

  static Future<AppSettings> getInstance() async {
    if (_appSettings == null) {
      _appSettings = AppSettings(await SharedPreferences.getInstance());
    }

    return _appSettings;
  }


  // Student's signin status
  bool get isSignedIn => _sharedPreferences.getBool(_kSignedInKey) ?? false;

  set isSignedIn(bool value) {
    _sharedPreferences.setBool(_kSignedInKey, value);
  }


  // Lich's period
  int get period => _sharedPreferences.getInt(_kPeriod) ?? 7;

  set period(int value) => _sharedPreferences.setInt(_kPeriod, value);


  // Enable auto get data
  bool get isAutoGet => _sharedPreferences.getBool(_kAutoGetKey) ?? false;

  set isAutoGet(bool value) {
    _sharedPreferences.setBool(_kAutoGetKey, value);
  }


  // Show ads
  bool get isShowAds => _sharedPreferences.getBool(_kShowAdsKey) ?? true;

  set isShowAds(bool value) {
    _sharedPreferences.setBool(_kShowAdsKey, value);
  }


  // List of terms for Diem & Diem Danh (Eg: Summer 2017)
  List<Term> get terms {
    try {
      final String encodedTerms = _sharedPreferences.getString(_kTermsKey);
      return encodedTerms
        .split(";")
        .map((termPair) {
          final term = termPair.split("=");
          return Term(int.parse(term[0]), term[1]);
        }).toList();
    } catch(err) {
      print(err);
      return [];
    }
  }

  set terms(List<Term> terms) {
    final String encodedTerms = terms.map((term) => term.toString()).join(";");
    _sharedPreferences.setString(_kTermsKey, encodedTerms);
  }


  // Selected term
  int get selectedTermValue => _sharedPreferences.getInt(_kSelectedTermKey);

  set selectedTermValue(int value) {
    _sharedPreferences.setInt(_kSelectedTermKey, value);
  }

  Term get selectedTerm {
    final selectedTermValueCopy = selectedTermValue;
    final termsCopy = terms;

    if (termsCopy == null || selectedTermValueCopy == null) {
      return Term(0, "");
    }

    final selectedTermIndex = termsCopy.indexWhere((term) => term.value == selectedTermValueCopy);

    if (selectedTermIndex == -1) {
      return Term(0, "");
    }

    return termsCopy[selectedTermIndex];
  }
}