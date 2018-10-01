import '../../task/get_data.dart';
import '../../utils/app_settings.dart';
import 'diem_contract.dart';

class DiemPresenter {
  AppSettings appSettings;
  DiemContract _view;

  DiemPresenter(this._view) {
    AppSettings.getInstance().then((settings) {
      appSettings = settings;

      _view.onBangDiemReceived(appSettings.dsBangDiem);
    });
  }

  void getBangDiem() {
    ApTask.getDsBangDiem().then((dsBangDiem) {
      _view.onBangDiemReceived(dsBangDiem);
    });
  }
}