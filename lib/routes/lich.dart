import 'package:flutter/material.dart';
import 'package:rounded_modal/rounded_modal.dart';
import '../configs.dart';
import '../model/lich.dart';
import '../model/group_lich.dart';
import '../task/get_data.dart';
import '../widgets/list_item.dart';
import '../widgets/lich_item.dart';

class LichScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LichScreenState();
}

class _LichScreenState extends State<LichScreen> {
  static const TextStyle _GhiChuTitleStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.black54);

  List<GroupLich> getDsGroupFrom(List<Lich> dsLich) {
    Map<String, List<Lich>> rawGroup = {};

    dsLich.forEach((Lich lich) {
      if (rawGroup.containsKey(lich.ngay)) {
        rawGroup[lich.ngay].add(lich);
      } else {
        rawGroup[lich.ngay] = [lich];
      }
    });

    return rawGroup.keys.map((date) => GroupLich(date: date, dsLich: rawGroup[date])).toList();
  }

  Widget _buildLichModal(Lich lich) {
    return Container(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          ListItem(
            title: "Ngày",
            subtitle: lich.ngay,
          ),
          ListItem(
            title: "Phòng",
            subtitle: lich.phong,
          ),
          ListItem(
            title: "Giảng Đường",
            subtitle: lich.giangDuong,
          ),
          ListItem(
            title: "Mã Môn",
            subtitle: lich.maMon,
          ),
          ListItem(
            title: "Môn",
            subtitle: lich.tenMon,
          ),
          ListItem(
            title: "Lớp",
            subtitle: lich.lop,
          ),
          ListItem(
            title: "Giảng Viên",
            subtitle: lich.giangVien,
          ),
          ListItem(
            title: "Slot Thời Gian",
            subtitle: "Slot ${lich.slot} (${lich.thoiGian})",
          ),
          ListItem(
            title: "Ghi Chú",
            child: Container(
              padding: EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("NỘI DUNG", style: _GhiChuTitleStyle),
                  Text(lich.chiTiet.noiDung),
                  SizedBox(height: 8.0),
                  Text("NHIỆM VỤ", style: _GhiChuTitleStyle),
                  Text(lich.chiTiet.nhiemVu),
                  SizedBox(height: 8.0),
                  Text("HỌC LIỆU", style: _GhiChuTitleStyle),
                  Text(lich.chiTiet.hocLieu),
                  SizedBox(height: 8.0),
                  Text("TÀI LIỆU", style: _GhiChuTitleStyle),
                  Text(lich.chiTiet.taiLieu),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupLich(dsGroup) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(4.0),
      itemCount: dsGroup.length,
      itemBuilder: (_, index) {
        final groupLich = dsGroup[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(groupLich.date, style: TextStyle(color: Colors.black54)),
            ),
            ListView.builder(
              padding: EdgeInsets.only(bottom: 12.0),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: groupLich.dsLich.length,
              itemBuilder: (_, lichIndex) => LichItem(
                lich: groupLich.dsLich[lichIndex],
                onTap: () {
                  showRoundedModalBottomSheet(
                    context: context,
                    color: Colors.white,
                    radius: 12.0,
                    builder: (_) => _buildLichModal(groupLich.dsLich[lichIndex]),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: ApTask.getLich(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              final List<GroupLich> dsGroup = getDsGroupFrom(snapshot.data);
              return _buildGroupLich(dsGroup);
            }
          }

          return Center(child: new CircularProgressIndicator());
        },
      ),
      decoration: kMainCardBoxDecoration
    );
  }
}

