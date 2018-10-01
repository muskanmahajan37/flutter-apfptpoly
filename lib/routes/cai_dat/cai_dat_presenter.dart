import '../../configs.dart';
import '../../model/term.dart';
import '../../task/get_data.dart';
import '../../utils/app_settings.dart';
import 'cai_dat_contract.dart';

class CaiDatPresenter {
  CaiDatContract _view;
  AppSettings _appSettings;

  CaiDatPresenter(this._view) {
    AppSettings.getInstance().then((settings) {
      _appSettings = settings;

      _view.onAutoGetChanged(_appSettings.isAutoGet);
      _view.onShowAdsChanged(_appSettings.isShowAds);
      _view.onSinhVienReceived(_appSettings.sinhVien);
      _view.onTermsReceived(_appSettings.terms);
      _view.onSelectedTermChanged(_appSettings.selectedTerm);
      _view.onSelectedPeriodChanged(kPeriods.firstWhere(
          (period) => period.value == _appSettings.period,
          orElse: () => kPeriods[0]));
    });
  }

  void getSinhVien() {
    ApTask.getSinhVien().then((sinhVien) {
      _view.onSinhVienReceived(sinhVien);
      _view.onTermsReceived(_appSettings.terms);
      _view.onSelectedTermChanged(_appSettings.selectedTerm);
    });
  }

  void saveAutoGet(bool value) {
    _appSettings.isAutoGet = value;
    _view.onAutoGetChanged(value);
  }

  void saveShowAds(bool value) {
    _appSettings.isShowAds = value;
    _view.onShowAdsChanged(value);
  }

  void saveSelectedPeriod(Period period) {
    _appSettings.period = period.value;
    _view.onSelectedPeriodChanged(period);
    _view.closeModal();
  }

  void saveSelectedTerm(Term term) {
    _appSettings.selectedTermValue = term.value;
    _view.onSelectedTermChanged(term);
    _view.closeModal();
  }
}
