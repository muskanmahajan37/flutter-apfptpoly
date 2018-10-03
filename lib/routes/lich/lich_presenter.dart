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

      if (appSettings.isAutoGet) {
        getLich();
      } else {
        final dsGroupLich = getDsGroupLichFrom(appSettings.dsLich);
        _view.onLichReceived(dsGroupLich);
      }
    });
  }

  void getLich() async {
    try {
      final isConnected = await getNetworkState();
      if (isConnected) {
        final dsLich = await ApTask.getLich();
        final dsGroupLich = getDsGroupLichFrom(dsLich);
        _view.onLichReceived(dsGroupLich);
      } else {
        final dsGroupLich = getDsGroupLichFrom(appSettings.dsLich);
        _view.onLichReceived(dsGroupLich);
      }
    } catch (err) {
      print(err);
      _view.onError("Lỗi không xác định!", err);
      final dsGroupLich = getDsGroupLichFrom(appSettings.dsLich);
      _view.onLichReceived(dsGroupLich);
    }
  }
}
