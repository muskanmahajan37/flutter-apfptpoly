import '../../model/group_lich.dart';

abstract class LichContract {
  void onLichReceived(List<GroupLich> dsLich);

  void onError(err);
}