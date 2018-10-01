import '../../model/bang_diem.dart';

abstract class DiemContract {
  void onBangDiemReceived(List<BangDiem> dsBangDiem);
}