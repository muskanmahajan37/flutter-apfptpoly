import 'package:flutter/material.dart';

import '../model/group_lich.dart';
import 'lich_item.dart';

class GroupLichItem extends StatelessWidget {
  final GroupLich groupLich;
  final Function onTap;

  const GroupLichItem(this.groupLich, { this.onTap });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(groupLich.date, style: TextStyle(color: Colors.black54)),
        ),
        ListView.builder(
          padding: EdgeInsets.only(bottom: 12.0),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: groupLich.dsLich.length,
          itemBuilder: (_, index) =>
            LichItem(
              lich: groupLich.dsLich[index],
              onTap: () => onTap(index),
            ),
        ),
      ],
    );
  }
}