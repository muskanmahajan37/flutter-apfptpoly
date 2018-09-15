import 'dart:async';
import 'dart:collection';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/term.dart';

class AppSettings {
  static const String _kSignedInKey = "is_sign_in";
  static const String _kAutoGetKey = "auto_get";
  static const String _kShowAdsKey = "show_ads";
  static const String _kTermsKey = "terms";
  static const String _kSelectedTermKey = "selected_term";

  final SharedPreferences _sharedPreferences;

  bool get isSignedIn => _sharedPreferences.getBool(_kSignedInKey) ?? true;

  set isSignedIn(bool value) {
    _sharedPreferences.setBool(_kSignedInKey, value);
  }

  bool get isAutoGet => _sharedPreferences.getBool(_kAutoGetKey) ?? false;

  set isAutoGet(bool value) {
    _sharedPreferences.setBool(_kAutoGetKey, value);
  }

  bool get isShowAds => _sharedPreferences.getBool(_kShowAdsKey) ?? true;

  set isShowAds(bool value) {
    _sharedPreferences.setBool(_kShowAdsKey, value);
  }

  List<Term> get terms {
    try {
      final String encodedTerms = _sharedPreferences.getString(_kTermsKey);
      return encodedTerms
        .split(";")
        .map((termPair) {
          final term = termPair.split("=");
          return Term(term[0], term[1]);
        });
    } catch(err) {
      print(err);
    } finally {
      return [];
    }
  }

  set terms(List<Term> terms) {
    final String encodedTerms = terms.map((term) => term.toString()).join(";");
    _sharedPreferences.setString(_kTermsKey, encodedTerms);
  }

  String get selectedTerm => _sharedPreferences.getString(_kSelectedTermKey);

  set selectedTerm(String value) {
    _sharedPreferences.setString(_kSelectedTermKey, value);
  }

  const AppSettings(this._sharedPreferences);

  static Future<AppSettings> getInstance() async {
    return AppSettings(await SharedPreferences.getInstance());
  }

}