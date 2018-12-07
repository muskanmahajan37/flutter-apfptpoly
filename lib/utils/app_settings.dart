import 'package:shared_preferences/shared_preferences.dart';

import '../model/bang_diem.dart';
import '../model/bang_diem_danh.dart';
import '../model/lich.dart';
import '../model/sinh_vien.dart';
import '../model/term.dart';

class AppKey {
  static const String signedIn = "is_sign_in";
  static const String autoGet = "auto_get";
  static const String showAds = "show_ads";
  static const String terms = "terms";
  static const String period = "period";
  static const String selectedTerm = "selected_term";
  static const String sinhVien = "sinh_vien";
  static const String lich = "lich";
  static const String diemDanh = "diemDanh";
  static const String diem = "diem";
}

class AppSettings {
  SharedPreferences _sharedPrefs;

  AppSettings() {
    SharedPreferences.getInstance().then((sharedPreferences) {
      _sharedPrefs = sharedPreferences;
    });
  }

  T _get<T>(String key, T defaultValue) =>
      _sharedPrefs.get(key) as T ?? defaultValue;

  void _remove(String key) => _sharedPrefs.remove(key);

  void _set(String key, dynamic value) {
    if (!value) {
      _remove(key);
    } else {
      _sharedPrefs.setString(key, value.toString());
    }
  }

  // Student's signin status
  bool get isSignedIn => _get<bool>(AppKey.signedIn, false);
  set isSignedIn(bool value) => _set(AppKey.signedIn, value);

  // Lich's period
  int get period => _get<int>(AppKey.period, 7);
  set period(int value) => _set(AppKey.period, value);

  // Enable auto get data
  bool get isAutoGet => _get<bool>(AppKey.autoGet, true);
  set isAutoGet(bool value) => _set(AppKey.autoGet, value);

  // Show ads
  bool get isShowAds => _get<bool>(AppKey.showAds, true);
  set isShowAds(bool value) => _set(AppKey.showAds, value);

  // Save SinhVien
  SinhVien get sinhVien =>
      SinhVien.fromJSONString(_get<String>(AppKey.sinhVien, ""));
  set sinhVien(SinhVien sinhVien) => _set(AppKey.sinhVien, sinhVien.toString());

  // List of terms for Diem & Diem Danh (Eg: Summer 2017)
  List<Term> get terms => Term.toList(_get<String>(AppKey.terms, ""));
  set terms(List<Term> terms) => _set(AppKey.terms, Term.toListString(terms));

  // Selected term
  int get selectedTermValue => _get<int>(AppKey.selectedTerm, 0);
  set selectedTermValue(int value) => _set(AppKey.selectedTerm, value);

  Term get selectedTerm {
    final selectedTermValueCopy = selectedTermValue;
    final termsCopy = terms;

    if (termsCopy == null || selectedTermValueCopy == null) {
      return null;
    }

    return termsCopy.firstWhere((term) => term.value == selectedTermValueCopy,
        orElse: () => null);
  }

  // Save dsLich
  List<Lich> get dsLich => Lich.toList(_get<String>(AppKey.lich, ""));
  set dsLich(List<Lich> dsLich) => _set(AppKey.lich, Lich.toListString(dsLich));

  // Save dsDiemDanh
  List<BangDiemDanh> get dsBangDiemDanh =>
      BangDiemDanh.toList(_get<String>(AppKey.lich, ""));
  set dsBangDiemDanh(List<BangDiemDanh> dsBangDiemDanh) =>
      _set(AppKey.lich, BangDiemDanh.toListString(dsBangDiemDanh));

  // Save dsBangDiem
  List<BangDiem> get dsBangDiem =>
      BangDiem.toList(_get<String>(AppKey.lich, ""));
  set dsBangDiem(List<BangDiem> dsBangDiem) =>
      _set(AppKey.lich, BangDiem.toListString(dsBangDiem));

  void resetSettings() {
    isSignedIn = false;
    terms = null;
    selectedTermValue = null;
  }
}
