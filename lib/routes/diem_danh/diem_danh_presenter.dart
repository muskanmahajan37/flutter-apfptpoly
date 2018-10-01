import '../../task/get_data.dart';
import '../../utils/app_settings.dart';
import 'diem_danh_contract.dart';

class DiemDanhPresenter {
  AppSettings appSettings;
  DiemDanhContract _view;

  DiemDanhPresenter(this._view) {
    AppSettings.getInstance().then((settings) {
      appSettings = settings;

      _view.onBangDiemDanhReceived(appSettings.dsBangDiemDanh);
    });
  }

  void getBangDiem() {
    ApTask.getDsBangDiemDanh().then((dsBangDiemDanh) {
      _view.onBangDiemDanhReceived(dsBangDiemDanh);
    });
  }
}