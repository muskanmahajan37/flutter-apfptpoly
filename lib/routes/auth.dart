import 'package:apfptpoly/utils/utils.dart';
import 'package:apfptpoly/widgets/alert_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../configs.dart';
import '../model/campus.dart';
import '../task/get_data.dart';
import '../utils/app_settings.dart';
import '../utils/cookie_handler.dart';
import '../widgets/logo.dart';
import '../widgets/visible.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FlutterWebviewPlugin webview = new FlutterWebviewPlugin();
  final CookieHandler cookieHandler = new CookieHandler();

  AppSettings appSettings;
  Campus _selectedCampus = kCampuses[0];
  bool _loading = false;

  @override
  void initState() {
    webview.close();
    webview.onStateChanged.listen(_onWebviewStateChanged);

    cookieHandler.setupStorage();

    AppSettings.getInstance().then((settings) {
      appSettings = settings;
    });

    super.initState();
  }

  @override
  void dispose() {
    webview.dispose();

    super.dispose();
  }

  _onLoginPress() async {
    try {
      final isConnected = await getNetworkState();
      if (isConnected) {
        setState(() {
          _loading = true;
        });

        webview.launch(
          "http://ap.poly.edu.vn/choose_campus.php?campus_id=${_selectedCampus.id}",
          userAgent: kUserAgent,
          hidden: true,
          clearCache: true,
          clearCookies: true,
          withJavascript: true,
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertMessage(
                title: "Lỗi",
                content: "Không có kết nối internet!",
              ),
        );
      }
    } catch (err) {
      print(err);
      showDialog(
        context: context,
        builder: (context) => AlertMessage(
              title: "Lỗi",
              content: "Lỗi không xác định: " + err.message,
            ),
      );
    }
  }

  _onWebviewStateChanged(WebViewStateChanged state) async {
    print(state.type.toString() + " - " + state.url);

    final type = state.type;
    final url = state.url;

    try {
      switch (type) {
        case WebViewState.startLoad:
        case WebViewState.shouldStart:
          if (url.startsWith(LoginStatus.authDone)) {
            webview.hide();
            final cookies = await webview.getCookies();
            cookieHandler.saveCookies("https://wwww.google.com", cookies);
            setState(() {
              _loading = true;
            });
          }
          break;

        case WebViewState.finishLoad:
          if (url == LoginStatus.finishedChoosingCampus) {
            print("test");
            if (Theme.of(context).platform == TargetPlatform.iOS) {
              webview.hide();
            } else {
              webview.close();
            }
            webview.launch(
              "http://ap.poly.edu.vn/hlogin.php?provider=Google",
              userAgent: kUserAgent,
              withJavascript: true,
            );
          } else if (url.startsWith(LoginStatus.startLogin)) {
            webview.show();
          } else if (url.contains(LoginStatus.wrongAccount)) {
            webview.close();
            print('wrong account');
            setState(() {
              _loading = false;
            });
            showDialog(
              context: context,
              builder: (context) => AlertMessage(
                    title: "Lỗi",
                    content: "Tài khoản này không thuộc FPT Polytechnic!",
                  ),
            );
          } else if (url.contains(LoginStatus.loginFailed)) {
            webview.close();
            print('login failed');
            setState(() {
              _loading = false;
            });
            showDialog(
              context: context,
              builder: (context) => AlertMessage(
                    title: "Lỗi",
                    content: "Cơ sở học không đúng, vui lòng chọn lại!",
                  ),
            );
          } else if (url.contains(LoginStatus.loginSuccess) ||
              url.startsWith(LoginStatus.feedback)) {
            print('login completed');

            final cookies = await webview.getCookies();
            cookieHandler.saveCookies("http://ap.poly.edu.vn", cookies);

            final sinhVien = await ApTask.getSinhVien();
            await ApTask.registerAccount(sinhVien.tenDangNhap,
                cookieHandler.readCookies("http://ap.poly.edu.vn"));

            appSettings.isSignedIn = true;
            Navigator.of(context).pushReplacementNamed('/main');
          }
          break;
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(flex: 3, child: Logo(loading: _loading)),
            Visible(
              visible: !_loading,
              animation: true,
              child: CampusButtonGroup(
                campuses: kCampuses,
                selectedCampus: _selectedCampus,
                onSelectCampus: (Campus campus) => setState(() {
                      _selectedCampus = campus;
                    }),
              ),
            ),
            Visible(
              visible: !_loading,
              animation: true,
              child: RaisedButton(
                padding: EdgeInsets.all(12.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999.0)),
                color: Colors.white,
                elevation: 0.0,
                highlightElevation: 0.0,
                child: Text(
                  'ĐĂNG NHẬP',
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: _onLoginPress,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CampusButtonGroup extends StatelessWidget {
  CampusButtonGroup(
      {@required this.campuses,
      @required this.selectedCampus,
      @required this.onSelectCampus});

  final List<Campus> campuses;
  final Campus selectedCampus;
  final Function onSelectCampus;

  Widget _buildButton(Campus campus) {
    return Flexible(
      child: InkWell(
        onTap: () => onSelectCampus(campus),
        borderRadius: BorderRadius.circular(kBorderRadius),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(kBorderRadius)),
          child: Center(
            child: Text(
              campus.name,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color:
                    campus == selectedCampus ? Colors.deepOrange : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
          color: Colors.deepOrange[800],
          borderRadius: BorderRadius.circular(kBorderRadius)),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints contrains) {
        return Stack(
          children: <Widget>[
            AnimatedPositioned(
              duration: Duration(milliseconds: 240),
              curve: Curves.ease,
              left: contrains.maxWidth /
                  campuses.length *
                  campuses.indexOf(selectedCampus),
              top: 0.0,
              bottom: 0.0,
              child: Container(
                width: contrains.maxWidth / campuses.length,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(kBorderRadius)),
              ),
            ),
            Row(
              children: campuses.map(_buildButton).toList(),
            ),
          ],
        );
      }),
    );
  }
}
