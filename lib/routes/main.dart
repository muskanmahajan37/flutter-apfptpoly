import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../utils/cookie_handler.dart';
import '../widgets/visible.dart';
import './lich.dart';
import './diem_danh.dart';
import './diem.dart';
import './cai_dat.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final CookieHandler cookieHandler = new CookieHandler();
  final FlutterWebviewPlugin webview = new FlutterWebviewPlugin();

  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();

    cookieHandler.setupStorage();
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
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.playlist_add_check), title: Text("Điểm Danh")),
          BottomNavigationBarItem(
              icon: Icon(Icons.filter_9), title: Text("Điểm")),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text("Cài đặt")),
        ]);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text("AP FPT Poly"),
          elevation: 0.0,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 2.0),
          child: Stack(children: <Widget>[
            Visible(visible: _selectedTab == 0, child: LichScreen()),
            Visible(visible: _selectedTab == 1, child: DiemDanhScreen()),
            Visible(visible: _selectedTab == 2, child: DiemScreen()),
            Visible(visible: _selectedTab == 3, child: CaiDatScreen()),
          ]),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar());
  }
}
