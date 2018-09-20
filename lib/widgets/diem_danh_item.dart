import 'package:flutter/material.dart';
import '../model/bang_diem_danh.dart';

class DiemDanhItem extends StatelessWidget {
  const DiemDanhItem({
    Key key,
    this.bangDiemDanh,
    this.onTap,
  }) : super(key: key);

  final BangDiemDanh bangDiemDanh;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        leading: Column(
          children: <Widget>[
            Text(
              "${bangDiemDanh.phanTramVang}%",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Text(
              "V: ${bangDiemDanh.tongVang}",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14.0
              ),
            ),
          ],
        ),
        title: Text(bangDiemDanh.tenMon),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Mã: ${bangDiemDanh.maMon}"),
            SizedBox(height: 2.0),
            Text("Lớp: ${bangDiemDanh.lop}"),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
