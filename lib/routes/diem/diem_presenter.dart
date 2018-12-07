import 'dart:async';

import 'package:apfptpoly/utils/utils.dart';

import '../../task/get_data.dart';
import '../../utils/app_settings.dart';
import 'diem_contract.dart';

class DiemPresenter {
  AppSettings appSettings;
  DiemContract _view;

  DiemPresenter(this._view) {
    // AppSettings.getInstance().then((settings) {
    //   appSettings = settings;

    //   if (appSettings.isAutoGet) {
    //     getBangDiem();
    //   } else {
    //     _view.onBangDiemReceived(appSettings.dsBangDiem);
    //   }
    // });
  }

  Future<void> getBangDiem() async {
    try {
      final isConnected = await getNetworkState();
      if (isConnected) {
        final dsBangDiem = await ApTask.getDsBangDiem();
        _view.onBangDiemReceived(dsBangDiem);
      } else {
        _view.onBangDiemReceived(appSettings.dsBangDiem);
      }
    } catch (err) {
      print(err);
      _view.onError("Lỗi không xác định!", err);
      _view.onBangDiemReceived(appSettings.dsBangDiem);
    }
  }
}
