import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({this.title, this.subtitle, this.subtitleWidget});

  final String title;
  final String subtitle;
  final Widget subtitleWidget;

  static const TextStyle _kTitleStyle =
      TextStyle(fontSize: 12.0, color: Colors.black54);
  static const TextStyle _kSubtitleStyle = TextStyle(color: Colors.black);
  static const Border _kBorderStyle =
      Border(bottom: BorderSide(color: Colors.black12, width: 1.0));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(border: _kBorderStyle),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: _kTitleStyle),
          SizedBox(height: 4.0),
          subtitleWidget == null
              ? Text(
                  subtitle,
                  style: _kSubtitleStyle,
                )
              : subtitleWidget
        ],
      ),
    );
  }
}
