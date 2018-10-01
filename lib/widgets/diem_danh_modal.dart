import 'package:flutter/material.dart';
import '../configs.dart';
import '../model/bang_diem_danh.dart';
import 'list_item.dart';

class DiemDanhModal extends StatelessWidget {
  final BangDiemDanh bangDiemDanh;

  const DiemDanhModal(this.bangDiemDanh);

  Color _getStateColor(String state) {
    switch (state) {
      case "Present":
      case "Asume present":
        return Colors.green;
      case "Absent":
        return Colors.red;
      default:
        return Colors.black38;
    }
  }

  Widget _buildTitle() {
    return ListItem(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              "Ngày",
              textAlign: TextAlign.center,
              style: kModalTitleTextStyle,
            ),
          ),
          Expanded(
            child: Text(
              "Ca",
              textAlign: TextAlign.center,
              style: kModalTitleTextStyle,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "Mô tả",
              textAlign: TextAlign.center,
              style: kModalTitleTextStyle,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Trạng thái",
              textAlign: TextAlign.center,
              style: kModalTitleTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBangDiemDanh() {
    return Expanded(
      child: ListView.builder(
        itemCount: bangDiemDanh.dsDiemDanh.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          final chiTiet = bangDiemDanh.dsDiemDanh[index];

          return ListItem(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    chiTiet.ngay,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    chiTiet.ca,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    chiTiet.moTa,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    chiTiet.trangThai,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _getStateColor(chiTiet.trangThai),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildTitle(),
          _buildBangDiemDanh(),
        ],
      ),
    );
  }
}
