import 'package:flutter/material.dart';
import '../model/diem_danh.dart';

class DiemDanhItem extends StatelessWidget {
  const DiemDanhItem({
    Key key,
    this.diemDanh,
    this.onTap,
  }) : super(key: key);

  final DiemDanh diemDanh;
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
              "${diemDanh.phanTramVang}%",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Text(
              "V: ${diemDanh.tongVang}",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14.0
              ),
            ),
          ],
        ),
        title: Text(diemDanh.tenMon),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Mã: ${diemDanh.maMon}"),
            SizedBox(height: 2.0),
            Text("Lớp: ${diemDanh.lop}"),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
