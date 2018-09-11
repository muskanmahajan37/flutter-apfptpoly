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

  List<Lich> dsLich = List<Lich>.generate(10, (index) => Lich(
    slot: "3",
    thoiGian: "12:00-14:00",
    tenMon: "Khởi sự doanh nghiệp",
    phong: "D402",
    lop: "PT12352-MOB",
    ngay: "Thứ 2, ngày 10/09/2018",
    giangDuong: "Khu Quan Hoa",
    maMon: "SYB301",
    giangVien: "thulk",
    chiTiet: ChiTietLich(
      noiDung: "Lorem ipsum",
      nhiemVu: "Lorem ipsum",
      hocLieu: "Lorem ipsum",
      taiLieu: "Lorem ipsum"
    )
  ));

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
              builder: (_) => _buildLichModal(dsLich[index]),
            );
          },
        )),
      decoration: kMainCardBoxDecoration
    );
  }
}
