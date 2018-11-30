import 'package:apfptpoly/utils/utils.dart';
import 'package:apfptpoly/widgets/alert_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../widgets/visible.dart';
import 'cai_dat/cai_dat_view.dart';
import 'diem/diem_view.dart';
import 'diem_danh/diem_danh_view.dart';
import 'lich/lich_view.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FlutterWebviewPlugin webview = FlutterWebviewPlugin();

  int _selectedTab = 0;
  String _title = "AP FPT Poly";

  @override
  void initState() {
    super.initState();
    getNetworkState().then((isConnected) {
      if (!isConnected) {
        showDialog(
          context: context,
          builder: (context) => AlertMessage(
                title: "Lỗi",
                content: "Không có kết nối internet!",
              ),
        );
      }
    });
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
        currentIndex: _selectedTab,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() {
              _selectedTab = index;
            }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            title: Text("Lịch"),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_check),
            title: Text("Điểm Danh"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_9),
            title: Text("Điểm"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Cài đặt"),
          ),
        ]);
  }

  void _onTitleReceived(String title) {
    setState(() {
      _title = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text(_title),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 2.0),
          child: Stack(children: <Widget>[
            Visible(visible: _selectedTab == 0, child: LichScreen()),
            Visible(visible: _selectedTab == 1, child: DiemDanhScreen()),
            Visible(visible: _selectedTab == 2, child: DiemScreen()),
            Visible(
                visible: _selectedTab == 3,
                child: CaiDatScreen(_onTitleReceived)),
          ]),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar());
  }
}
