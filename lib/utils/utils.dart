import 'dart:async';

import 'package:connectivity/connectivity.dart';

import '../model/group_lich.dart';
import '../model/lich.dart';

List<GroupLich> getDsGroupLichFrom(List<Lich> dsLich) {
  if (dsLich == null) {
    return null;
  }

  Map<String, List<Lich>> rawGroup = {};

  dsLich.forEach((Lich lich) {
    if (rawGroup.containsKey(lich.ngay)) {
      rawGroup[lich.ngay].add(lich);
    } else {
      rawGroup[lich.ngay] = [lich];
    }
  });

  return rawGroup.keys
      .map((date) => GroupLich(date: date, dsLich: rawGroup[date]))
      .toList();
}

Future<bool> getNetworkState() async {
  try {
    final ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  } catch (err) {
    print(err);
    return false;
  }
}
