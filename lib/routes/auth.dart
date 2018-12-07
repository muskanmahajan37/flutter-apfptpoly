import 'package:apfptpoly/utils/utils.dart';
import 'package:apfptpoly/widgets/alert_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../app_model.dart';
import '../configs.dart';
import '../model/campus.dart';
import '../utils/app_settings.dart';
import '../utils/cookie_handler.dart';
import '../task/get_data.dart';
import '../widgets/logo.dart';
import '../widgets/visible.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FlutterWebviewPlugin webview = FlutterWebviewPlugin();

  CookieHandler _cookieHandler;
  AppSettings _appSettings;

  Campus _selectedCampus = kCampuses[0];
  bool _loading = false;

  @override
  void initState() {
    super.initState();

    AppModel appModel = AppModel.of(context);
    _cookieHandler = appModel.cookieHandler;
    _appSettings = appModel.appSettings;

    webview.close();
    webview.onStateChanged.listen(_onWebviewStateChanged);
  }

  @override
  void dispose() {
    webview.dispose();

    super.dispose();
  }

  _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertMessage(
            title: "Lỗi",
            content: message,
          ),
    );

    setState(() {
      _loading = false;
    });
  }

  _login() {
    setState(() {
      _loading = true;
    });

    webview.launch(
      "${Urls.chooseCampus}?campus_id=${_selectedCampus.id}",
      userAgent: kUserAgent,
      hidden: true,
      clearCache: true,
      clearCookies: true,
      withJavascript: true,
    );
  }

  _onLoginPress() async {
    final isConnected = await getNetworkState();
    if (isConnected) {
      _login();
    } else {
      _showErrorDialog("Không có kết nối internet!");
    }
  }

  _onFinishChoosingCampus() {
    webview.close();

    webview.launch(
      Urls.login,
      userAgent: kUserAgent,
      withJavascript: true,
    );
  }

  _onAuthDone() async {
    webview.hide();
    final cookies = await webview.getCookies();
    _cookieHandler.saveCookies(CookieType.google, cookies);

    setState(() {
      _loading = true;
    });
  }

  _onStartLogin() {
    webview.show();
  }

  _onLoginCompleted() async {
    final cookies = await webview.getCookies();
    _cookieHandler.saveCookies(CookieType.ap, cookies);

    final sinhVien = await ApTask.getSinhVien();
    final result = await ApTask.registerAccount(
        sinhVien.tenDangNhap, _cookieHandler.readCookies(CookieType.ap));

    if (result != "ok") {
      _cookieHandler.saveCookiesString(CookieType.ap, result);
    }

    _appSettings.isSignedIn = true;
    Navigator.of(context).pushReplacementNamed('/main');
  }

  _onError(String status) {
    switch (status) {
      case LoginStatus.wrongAccount:
        webview.close();
        _showErrorDialog("Tài khoản này không thuộc FPT Polytechnic!");
        break;

      case LoginStatus.loginFailed:
        webview.close();
        _showErrorDialog("Cơ sở học không đúng, vui lòng chọn lại!");
        break;
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
            _onAuthDone();
          }
          break;

        case WebViewState.finishLoad:
          if (url == LoginStatus.finishedChoosingCampus) {
            _onFinishChoosingCampus();
          } else if (url.startsWith(LoginStatus.startLogin)) {
            _onStartLogin();
          } else if (url.contains(LoginStatus.wrongAccount)) {
            _onError(LoginStatus.wrongAccount);
          } else if (url.contains(LoginStatus.loginFailed)) {
            _onError(LoginStatus.loginFailed);
          } else if (url.contains(LoginStatus.loginSuccess) ||
              url.startsWith(LoginStatus.feedback)) {
            _onLoginCompleted();
          }
          break;
      }
    } catch (err) {
      print(err);
      _showErrorDialog("Lỗi không xác định: " + err.toString());
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
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
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
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
                  borderRadius: BorderRadius.circular(kBorderRadius),
                ),
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
