import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/bang_diem.dart';
import '../model/bang_diem_danh.dart';
import '../model/lich.dart';
import '../model/sinh_vien.dart';
import '../model/term.dart';

class AppSettings {
  static const String _kSignedInKey = "is_sign_in";
  static const String _kAutoGetKey = "auto_get";
  static const String _kShowAdsKey = "show_ads";
  static const String _kTermsKey = "terms";
  static const String _kPeriod = "period";
  static const String _kSelectedTermKey = "selected_term";
  static const String _kSinhVien = "sinh_vien";
  static const String _kLich = "lich";
  static const String _kDiemDanh = "diemDanh";
  static const String _kDiem = "diem";

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

  set isSignedIn(bool value) => _sharedPreferences.setBool(_kSignedInKey, value);


  // Lich's period
  int get period => _sharedPreferences.getInt(_kPeriod) ?? 7;

  set period(int value) => _sharedPreferences.setInt(_kPeriod, value);


  // Enable auto get data
  bool get isAutoGet => _sharedPreferences.getBool(_kAutoGetKey) ?? false;

  set isAutoGet(bool value) => _sharedPreferences.setBool(_kAutoGetKey, value);


  // Show ads
  bool get isShowAds => _sharedPreferences.getBool(_kShowAdsKey) ?? true;

  set isShowAds(bool value) => _sharedPreferences.setBool(_kShowAdsKey, value);


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
    if (terms == null) {
      _sharedPreferences.remove(_kTermsKey);
    } else {
      final String encodedTerms = terms.map((term) => term.toString()).join(";");
      _sharedPreferences.setString(_kTermsKey, encodedTerms);
    }
  }


  // Selected term
  int get selectedTermValue => _sharedPreferences.getInt(_kSelectedTermKey);

  set selectedTermValue(int value) {
    if (value == null) {
      _sharedPreferences.remove(_kSelectedTermKey);
    } else {
      _sharedPreferences.setInt(_kSelectedTermKey, value);
    }
  }

  Term get selectedTerm {
    final selectedTermValueCopy = selectedTermValue;
    final termsCopy = terms;

    if (termsCopy == null || selectedTermValueCopy == null) {
      return null;
    }

    return termsCopy.firstWhere((term) => term.value == selectedTermValueCopy, orElse: () => null);
  }


  // Save SinhVien
  SinhVien get sinhVien {
    try {
      final str = _sharedPreferences.getString(_kSinhVien);
      final jsonSinhVien = json.decode(str);

      return SinhVien.fromJSON(jsonSinhVien);
    } catch (err) {
      print(err);
      return null;
    }
  }

  set sinhVien(SinhVien sinhVien) {
    final String str = json.encode(sinhVien.toJson());
    _sharedPreferences.setString(_kSinhVien, str);
  }


  // Save dsLich
  List<Lich> get dsLich {
    try {
      final str = _sharedPreferences.getString(_kLich);
      final jsonDsLich = json.decode(str);

      return jsonDsLich.map<Lich>((jsonLich) => Lich.fromJson(jsonLich)).toList();
    } catch (err) {
      print(err);
      return null;
    }
  }

  set dsLich(List<Lich> dsLich) {
    try {
      final jsonDsLich = dsLich.map((lich) => lich.toJson()).toList();

      _sharedPreferences.setString(_kLich, json.encode(jsonDsLich));
    } catch (err) {
      print(err);
    }
  }


  // Save dsDiemDanh
  List<BangDiemDanh> get dsBangDiemDanh {
    try {
      final str = _sharedPreferences.getString(_kDiemDanh);
      final jsonDsBangDiemDanh = json.decode(str);

      return jsonDsBangDiemDanh.map<BangDiemDanh>((jsonBangDiemDanh) => BangDiemDanh.fromJson(jsonBangDiemDanh)).toList();
    } catch (err) {
      print(err);
      return null;
    }
  }

  set dsBangDiemDanh(List<BangDiemDanh> dsBangDiemDanh) {
    try {
      final jsonDsBangDiemDanh = dsBangDiemDanh.map((bangDiemDanh) => bangDiemDanh.toJson()).toList();

      _sharedPreferences.setString(_kDiemDanh, json.encode(jsonDsBangDiemDanh));
    } catch (err) {
      print(err);
    }
  }


  // Save dsBangDiem
  List<BangDiem> get dsBangDiem {
    try {
      final str = _sharedPreferences.getString(_kDiem);
      final jsonDsBangDiem = json.decode(str);

      return jsonDsBangDiem.map<BangDiem>((jsonBangDiem) => BangDiem.fromJson(jsonBangDiem)).toList();
    } catch (err) {
      print(err);
      return null;
    }
  }

  set dsBangDiem(List<BangDiem> dsBangDiem) {
    try {
      final jsonDsBangDiem = dsBangDiem.map((bangDiem) => bangDiem.toJson()).toList();

      _sharedPreferences.setString(_kDiem, json.encode(jsonDsBangDiem));
    } catch (err) {
      print(err);
    }
  }

  void resetSettings() {
    isSignedIn = false;
    terms = null;
    selectedTermValue = null;
  }
}