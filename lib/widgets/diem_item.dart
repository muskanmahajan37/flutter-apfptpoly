import 'package:flutter/material.dart';
import '../model/diem.dart';

class DiemItem extends StatelessWidget {
  const DiemItem(
      {Key key,
        this.diem,
        this.onTap,
      }) : super(key: key);

  final Diem diem;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        leading: SizedBox(
          width: 46.0,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.check,
              color: Colors.green,
              size: 42.0,
            )
          ),
        ),
        title: Text(diem.tenMon),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Lớp: ${diem.lop}"),
            SizedBox(height: 2.0),
            Text("Trung bình: ${diem.trungBinh}"),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
