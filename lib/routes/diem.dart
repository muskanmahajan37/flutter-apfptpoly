import 'package:flutter/material.dart';
import '../model/diem.dart';
import '../widgets/diem_item.dart';


class DiemScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DiemScreenState();
}

class _DiemScreenState extends State<DiemScreen> {
  List<Diem> dsDiem = List<Diem>.generate(10, (index) {
    return Diem(
      tenMon: "Mobile Marketing",
      trangThai: "PASSED",
      trungBinh: "8.2",
      maMon: "MOB307",
      lop: "MOB307.2",
    );
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
          itemCount: dsDiem.length,
          itemBuilder: (_, index) => DiemItem(
            diem: dsDiem[index],
            onTap: () {},
          )
      ),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.08),
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.0))
      ),
    );
  }
}