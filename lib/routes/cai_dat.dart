import 'package:flutter/material.dart';
import '../configs.dart';

class CaiDatScreen extends StatelessWidget {
  const CaiDatScreen();

  static const EdgeInsets _kCardMargin =
      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0);

  Widget _buildCard(
      {@required IconData icon,
      @required String text,
      Function onTap,
      Widget trailing}) {
    return Card(
      margin: _kCardMargin,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.deepOrange,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(text),
        trailing: trailing,
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
        children: <Widget>[
          const Center(
            child: const SizedBox(
              width: 160.0,
              height: 160.0,
              child: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://scontent.fhan2-2.fna.fbcdn.net/v/t1.0-9/14055088_835216616580439_407796087641692406_n.jpg?_nc_cat=0&oh=41a6d064f4e67b7d9b04226b240e6aad&oe=5BF052C8")),
            ),
          ),
          const SizedBox(height: 16.0),
          Center(
              child: Text("Pham Sy Hung",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26.0,
                      color: Colors.black87))),
          const SizedBox(height: 4.0),
          Center(
              child: Text("hungpsh04930@fpt.edu.vn",
                  style: TextStyle(color: Colors.black54))),
          const SizedBox(height: 24.0),
          _buildCard(icon: Icons.person, text: "Thông tin cá nhân"),
          _buildCard(icon: Icons.whatshot, text: "Tin tức"),
          _buildCard(
              icon: Icons.event,
              text: "Lịch học",
              trailing: const Text("14 ngày tới",
                  style: TextStyle(color: Colors.deepOrange))),
          _buildCard(
              icon: Icons.event_note,
              text: "Kỳ",
              trailing: const Text("Summer 2018",
                  style: TextStyle(color: Colors.deepOrange))),
          _buildCard(
            icon: Icons.refresh,
            text: "Tự động tải",
            trailing: Checkbox(value: true, onChanged: (val) {}),
          ),
          _buildCard(
            icon: Icons.favorite,
            text: "Hiện quảng cáo",
            trailing: Checkbox(value: true, onChanged: (val) {}),
          ),
        ],
      ),
      decoration: kMainCardBoxDecoration,
    );
  }
}
