import 'package:flutter/material.dart';

import '../model/lich.dart';
import 'list_item.dart';

class LichModal extends StatelessWidget {
  static const TextStyle _GhiChuTitleStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.black54);

  final Lich lich;

  const LichModal(this.lich);

  Widget _buildChiTiet() {
    final chiTiet = lich.chiTiet;

    return Container(
      padding: EdgeInsets.only(left: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("NỘI DUNG", style: _GhiChuTitleStyle),
          Text(chiTiet.noiDung),
          SizedBox(height: 8.0),
          Text("NHIỆM VỤ", style: _GhiChuTitleStyle),
          Text(chiTiet.nhiemVu),
          SizedBox(height: 8.0),
          Text("HỌC LIỆU", style: _GhiChuTitleStyle),
          Text(chiTiet.hocLieu),
          SizedBox(height: 8.0),
          Text("TÀI LIỆU", style: _GhiChuTitleStyle),
          Text(chiTiet.taiLieu),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            child: _buildChiTiet(),
          ),
        ],
      ),
    );
  }
}