import '../../task/get_data.dart';
import '../../utils/app_settings.dart';
import '../../utils/utils.dart';
import 'lich_contract.dart';

class LichPresenter {
  AppSettings appSettings;
  LichContract _view;

  LichPresenter(this._view) {
    AppSettings.getInstance().then((settings) {
      appSettings = settings;

      final dsGroupLich = getDsGroupLichFrom(appSettings.dsLich);
      _view.onLichReceived(dsGroupLich);
    });
  }

  void getLich() {
    ApTask.getLich()
      .then((dsLich) {
        final dsGroupLich = getDsGroupLichFrom(dsLich);
        _view.onLichReceived(dsGroupLich);
      })
      .catchError((err) => _view.onError(err));
  }
}