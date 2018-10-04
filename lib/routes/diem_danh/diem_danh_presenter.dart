import 'dart:async';

import 'package:apfptpoly/utils/utils.dart';

import '../../task/get_data.dart';
import '../../utils/app_settings.dart';
import 'diem_danh_contract.dart';

class DiemDanhPresenter {
  AppSettings appSettings;
  DiemDanhContract _view;

  DiemDanhPresenter(this._view) {
    AppSettings.getInstance().then((settings) {
      appSettings = settings;

      if (appSettings.isAutoGet) {
        getBangDiemDanh();
      } else {
        _view.onBangDiemDanhReceived(appSettings.dsBangDiemDanh);
      }
    });
  }

  Future<void> getBangDiemDanh() async {
    try {
      final isConnected = await getNetworkState();
      if (isConnected) {
        final dsBangDiemDanh = await ApTask.getDsBangDiemDanh();
        _view.onBangDiemDanhReceived(dsBangDiemDanh);
      } else {
        _view.onBangDiemDanhReceived(appSettings.dsBangDiemDanh);
      }
    } catch (err) {
      print(err);
      _view.onError("Lỗi không xác định!", err);
      _view.onBangDiemDanhReceived(appSettings.dsBangDiemDanh);
    }
  }
}
