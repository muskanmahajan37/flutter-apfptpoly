import '../../configs.dart';
import '../../model/sinh_vien.dart';
import '../../model/term.dart';

abstract class CaiDatContract {
  void onTermsReceived(List<Term> terms);

  void onSinhVienReceived(SinhVien sinhVien);

  void onAutoGetChanged(bool value);

  void onShowAdsChanged(bool value);

  void onSelectedPeriodChanged(Period period);

  void onSelectedTermChanged(Term term);

  void closeModal();

  void onError(String message, err);
}
