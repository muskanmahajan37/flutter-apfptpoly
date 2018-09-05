import 'package:flutter/material.dart';
import '../model/lich.dart';

class LichItem extends StatelessWidget {
  const LichItem({
    Key key,
    @required this.lich,
    this.onTap,
  }) : super(key: key);

  final Lich lich;
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
              "Slot ${lich.slot}",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.0
              ),
            ),
            Text(
              lich.thoiGian,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 8.0,
              ),
            ),
          ],
        ),
        title: Text(lich.tenMon),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Phòng: ${lich.phong}"),
            SizedBox(height: 2.0),
            Text("Lớp: ${lich.lop}"),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
