import 'package:flutter/material.dart';
import '../model/lich.dart';
import '../widgets/lich_item.dart';


class LichScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LichScreenState();
}

class _LichScreenState extends State<LichScreen> {
  List<Lich> dsLich = List<Lich>.generate(10, (index) {
    return Lich(
      slot: "3",
      thoiGian: "12:00-14:00",
      tenMon: "Android Networking",
      phong: "H204",
      lop: "PT12352-MOB",
    );
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
        itemCount: dsLich.length,
        itemBuilder: (_, index) => LichItem(
          lich: dsLich[index],
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