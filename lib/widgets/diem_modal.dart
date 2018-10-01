import 'package:flutter/material.dart';
import '../configs.dart';
import '../model/bang_diem.dart';
import 'list_item.dart';

class DiemModal extends StatelessWidget {
  final BangDiem bangDiem;

  const DiemModal(this.bangDiem);

  Widget _buildTitle() {
    return ListItem(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              "Tên",
              style: kModalTitleTextStyle,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "Trọng số",
              textAlign: TextAlign.center,
              style: kModalTitleTextStyle,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "Điểm",
              textAlign: TextAlign.center,
              style: kModalTitleTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBangDiem() {
    final dsDiem = bangDiem.dsDiem;

    return Expanded(
      child: ListView.builder(
        itemCount: dsDiem.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          final chiTiet = dsDiem[index];

          return ListItem(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(chiTiet.ten),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    chiTiet.trongSo,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    chiTiet.diem,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
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
          _buildBangDiem(),
        ],
      ),
    );
  }
}
