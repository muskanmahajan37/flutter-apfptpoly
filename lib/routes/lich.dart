import 'package:flutter/material.dart';
import 'package:rounded_modal/rounded_modal.dart';
import '../configs.dart';
import '../model/lich.dart';
import '../widgets/list_item.dart';
import '../widgets/lich_item.dart';

class LichScreen extends StatefulWidget {
  const LichScreen();

  @override
  State<StatefulWidget> createState() => _LichScreenState();
}

class _LichScreenState extends State<LichScreen> {
  static const TextStyle _GhiChuTitleStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.black54);
  List<Lich> dsLich = List<Lich>.generate(10, (index) {
    return const Lich(
      slot: "3",
      thoiGian: "12:00-14:00",
      tenMon: "Android Networking",
      phong: "H204",
      lop: "PT12352-MOB",
    );
  });

  Widget _buildLichModal(BuildContext context) {
    return Container(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          ListItem(
            title: "Ngày",
            subtitle: "Thứ 2, ngày 10/09/2018",
          ),
          ListItem(
            title: "Phòng",
            subtitle: "D402",
          ),
          ListItem(
            title: "Giảng Đường",
            subtitle: "Khu Quan Hoa",
          ),
          ListItem(
            title: "Mã Môn",
            subtitle: "SYB301",
          ),
          ListItem(
            title: "Môn",
            subtitle: "Khởi sự doanh nghiệp",
          ),
          ListItem(
            title: "Lớp",
            subtitle: "PT12352-MOB",
          ),
          ListItem(
            title: "Giảng Viên",
            subtitle: "thulk",
          ),
          ListItem(
            title: "Slot Thời Gian",
            subtitle: "Slot 5 (từ 16:20:00 đến 18:20:00",
          ),
          ListItem(
            title: "Ghi Chú",
            subtitleWidget: Container(
              padding: EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("NỘI DUNG", style: _GhiChuTitleStyle),
                  Text("Lorem ipsum"),
                  SizedBox(height: 8.0),
                  Text("NHIỆM VỤ", style: _GhiChuTitleStyle),
                  Text("Lorem ipsum"),
                  SizedBox(height: 8.0),
                  Text("HỌC LIỆU", style: _GhiChuTitleStyle),
                  Text("Lorem ipsum"),
                  SizedBox(height: 8.0),
                  Text("TÀI LIỆU", style: _GhiChuTitleStyle),
                  Text("Lorem ipsum"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
            itemCount: dsLich.length,
            itemBuilder: (_, index) => LichItem(
                  lich: dsLich[index],
                  onTap: () {
                    showRoundedModalBottomSheet(
                      context: context,
                      color: Colors.white,
                      radius: 12.0,
                      builder: _buildLichModal,
                    );
                  },
                )),
        decoration: kMainCardBoxDecoration);
  }
}
