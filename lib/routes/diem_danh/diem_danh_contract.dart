import '../../model/bang_diem_danh.dart';

abstract class DiemDanhContract {
  void onBangDiemDanhReceived(List<BangDiemDanh> dsBangDiemDanh);

  void onError(String message, err);
}
