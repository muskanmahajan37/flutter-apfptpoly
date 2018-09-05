import 'package:flutter/material.dart';

class CaiDatScreen extends StatelessWidget {
  static const EdgeInsets _kCardMargin = const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
        children: <Widget>[
            Center(
              child: SizedBox(
                width: 160.0,
                height: 160.0,
                child: CircleAvatar(
                  backgroundImage: NetworkImage("https://scontent.fhan2-2.fna.fbcdn.net/v/t1.0-9/14055088_835216616580439_407796087641692406_n.jpg?_nc_cat=0&oh=41a6d064f4e67b7d9b04226b240e6aad&oe=5BF052C8")
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Center(child: Text("Pham Sy Hung", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0))),
            SizedBox(height: 4.0),
            Center(child: Text("hungpsh04930@fpt.edu.vn")),
            SizedBox(height: 24.0),
            Card(
              margin: _kCardMargin,
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text("Thông tin cá nhân"),
                onTap: () {},
              ),
            ),
            Card(
              margin: _kCardMargin,
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.whatshot),
                ),
                title: Text("Tin tức"),
                onTap: () {},
              ),
            ),
            Card(
              margin: _kCardMargin,
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.event),
                ),
                title: Text("Lịch học"),
                trailing: Text("14 ngày tới"),
                onTap: () {},
              ),
            ),
            Card(
              margin: _kCardMargin,
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.event_note),
                ),
                title: Text("Kỳ"),
                trailing: Text("Summer 2018"),
                onTap: () {},
              ),
            ),
            Card(
              margin: _kCardMargin,
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.refresh),
                ),
                title: Text("Tự động tải"),
                trailing: Checkbox(value: true, onChanged: (val) {}),
                onTap: () {},
              ),
            ),
            Card(
              margin: _kCardMargin,
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.favorite),
                ),
                title: Text("Hiện quảng cáo"),
                trailing: Checkbox(value: true, onChanged: (val) {}),
                onTap: () {},
              ),
            ),
          ],
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.08),
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0))
      ),
    );
  }
}